{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE NoMonomorphismRestriction #-}
import Control.Arrow
import Control.Monad.IO.Class
import Control.Monad
import Control.Comonad
import Language.Haskell.Codo
import Data.Monoid

-- type matched, but no show instances....
testCodo  :: (Num b, Monoid a) => (t, t') -> (a -> (b', b)) -> a -> b
testCodo (f,g) = [codo| (f,g) => r  <- (+3).extract (f, g)
                                 r' <- (*5).extract r
                                 extract r' |]

output :: IO ()
output = do
  let comp = ("test", 1) =>> (+3).extract =>> (*5).extract =>> show.extract
  putStrLn $ show comp
