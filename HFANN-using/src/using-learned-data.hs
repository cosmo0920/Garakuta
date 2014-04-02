import HFANN

fileName :: String
fileName = "or.ann"

main :: IO ()
main = do
  -- Load an ANN from file \'or.ann\'
  withSavedFann fileName $ \fann -> do
    -- Run the ANN on input
    let input = [1,1]
    res <- runFann fann input
    putStrLn $ "or test  " ++ show input ++ " -> " ++ show (head res)
    let input2 = [1,0]
    res2 <- runFann fann input2
    putStrLn $ "or test2 " ++ show input2 ++ " -> " ++ show (head res2)
    let input3 = [0,1]
    res3 <- runFann fann input3
    putStrLn $ "or test3 " ++ show input3 ++ " -> " ++ show (head res3)
    let input4 = [0,0]
    res4 <- runFann fann input4
    putStrLn $ "or test4 " ++ show input4 ++ " -> " ++ show (head res4)
{- example outputs:
   or test  [1.0,1.0] ->  0.9691433433542798   => about 1
   or test2 [1.0,0.0] ->  0.966515509096789    => about 1
   or test3 [0.0,1.0] ->  0.9664240888200766   => about 1
   or test4 [0.0,0.0] -> -5.894598841081122e-2 => about 0
-}