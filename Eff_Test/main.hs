import Control.Eff
import Control.Eff.State
import Control.Eff.Exception
import Control.Eff.Choose
import Control.Eff.Coroutine
import Control.Eff.Cut
import Control.Eff.Lift
import Control.Eff.Trace
import Control.Monad

main :: IO ()
main = do
  showReader
  showChoose
  showCut
  showLift
  showState
  showCoroutine
  showException

showReader :: IO ()
showReader = do
  putStrLn "--Eff.Reader--"
  let num   = run $ t1r
      num2  = t1rr
  putStrLn $ show num
  putStrLn $ show num2

showChoose :: IO ()
showChoose = do
  putStrLn "--Eff.Choose--"
  let ch    = run exc11
  putStrLn $ show ch

showCut :: IO ()
showCut = do
  putStrLn "--Eff.Cut--"
  let cnum  = tcut1r
      cnum2 = tcut2r
      cnum3 = tcut3r
  putStrLn $ show cnum
  putStrLn $ show cnum2
  putStrLn $ show cnum3

showLift :: IO ()
showLift = do
  putStrLn "--Eff.Lift--"
  tl1r

showState :: IO ()
showState = do
  putStrLn "--Eff.State--"
  let snum  = ts1r
      snum2 = ts2r
  putStrLn $ show snum
  putStrLn $ show snum2

showCoroutine :: IO ()
showCoroutine = do
  putStrLn "--Eff.Coroutine--"
  c1 >> c2

showException :: IO ()
showException = do
  putStrLn "--Eff.Exception--"
  let ev  = ter1
      ev2 = ter2
  putStrLn $ show ev
  putStrLn $ show ev2
{- Reader -}
t1 :: Member (Reader Int) r => Eff r Int
t1 = do v <- getReader
        return (v + 1:: Int)

t1r :: Eff r Int
t1r = runReader t1 (10::Int)

t1rr :: Int
t1rr = run t1r
{- Choose -}
add :: Monad m => m Int -> m Int -> m Int
add = liftM2 (+)

exc1 :: Member Choose r => Eff r Int
exc1 = return 1 `add` choose [1,2,3]

exc11 :: forall r. Eff r [Int]
exc11 = runChoice exc1
{- Cut -}
-- The signature is inferred
tcut1 :: (Member Choose r, Member (Exc CutFalse) r) => Eff r Int
tcut1 = (return (1::Int) `mplus'` return 2) `mplus'`
         ((cutfalse `mplus'` return 4) `mplus'`
          return 5)

tcut1r :: [Int]
tcut1r = run . runChoice $ call tcut1
-- [1,2]

tcut2 :: (Member Choose r, Member (Exc CutFalse) r) => Eff r Int
tcut2 = return (1::Int) `mplus'`
         call (return 2 `mplus'` (cutfalse `mplus'` return 3) `mplus'`
               return 4)
       `mplus'` return 5

tcut2r :: [Int]
tcut2r = run . runChoice $ call tcut2

-- More nested calls
tcut3 :: (Member Choose r, Member (Exc CutFalse) r) => Eff r Int
tcut3 = call tcut1 `mplus'` call (tcut2 `mplus'` cutfalse)

tcut3r :: [Int]
tcut3r = run . runChoice $ call tcut3
-- [1,2,1,2,5]
{- Lifting -}
tl1 :: (Member (Lift IO) r, Member (Reader Int) r) => Eff r ()
tl1 = getReader >>= \(x::Int) -> lift . print $ x

tl1r :: IO ()
tl1r = runLift (runReader tl1 (5::Int))
-- 5

{- State -}
ts1 :: Member (State Int) r => Eff r Int
ts1 = do
  putState (10 ::Int)
  x <- getState
  return (x::Int)

ts1r :: (Int, Int)
ts1r = run $ runState (0::Int) ts1

ts2 :: Member (State Int) r => Eff r Int
ts2 = do
  putState (10::Int)
  x <- getState
  putState (20::Int)
  y <- getState
  return (x+y)

ts2r :: (Int, Int)
ts2r = run (runState (0::Int) ts2)
{- Conroutine & Trace -}
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

{- Exception -}
-- exceptions and state
incr :: Member (State Int) r => Eff r ()
incr = getState >>= putState . (+ (1::Int))

tes1 :: (Member (State Int) r, Member (Exc [Char]) r) => Eff r b
tes1 = do
  incr
  throwExc "exc"

ter1 :: (Int, Either String String)
ter1 = run $ runState (1::Int) (runExc tes1)
-- (2, Left "exc")

ter2 :: Either String (Int, String)
ter2 = run $ runExc (runState (1::Int) tes1)
-- Left "exc"
