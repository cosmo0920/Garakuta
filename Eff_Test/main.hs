{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE IncoherentInstances #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE ExistentialQuantification #-}
{-# LANGUAGE ScopedTypeVariables #-}

import Control.Eff
import Control.Eff.State
import Control.Eff.Exception
import Control.Eff.Choose
import Control.Eff.Coroutine
import Control.Eff.Trace
import Control.Monad
import Control.Monad.Instances
import Data.Typeable
import Data.IORef
main :: IO ()
main = do
  let num  = run $ t1r
      num2 = t1rr
      er   = run exc11
  putStrLn $ show num
  putStrLn $ show num2
  putStrLn $ show er
  c1 >> c2
  return ()

t1 :: Member (Reader Int) r => Eff r Int
t1 = do v <- getReader
        return (v + 1:: Int)

t1r :: Eff r Int
t1r = runReader t1 (10::Int)

t1rr :: Int
t1rr = run t1r

add :: Monad m => m Int -> m Int -> m Int
add = liftM2 (+)

exc1 :: Member Choose r => Eff r Int
exc1 = return 1 `add` choose [1,2,3]

exc11 :: forall r. Eff r [Int]
exc11 = runChoice exc1

th1 :: Member (Yield Int) r => Eff r ()
th1 = yield (1::Int) >> yield (2::Int)

thf :: Member (Yield Float) r => Eff r ()
thf = yield (1.0::Float) >> yield (2.0::Float)

c1 :: IO ()
c1 = runTrace (loop =<< runC th1)
 where loop (Y x k) = trace (show (x::Int)) >> k () >>= loop
       loop Done    = trace "Done"

c2 :: IO ()
c2 = runTrace (loop =<< runC thf)
 where loop (Y x k) = trace (show (x::Float)) >> k () >>= loop
       loop Done    = trace "Done"
