import HFANN

-- Nodes definition for an ANN of 2 input, 3 hidden and 1 output nodes
num_input :: Int
num_input = 2
num_layer :: Int
num_layer = 3
num_output :: Int
num_output = 1

fannDef :: [Int]
fannDef = [num_input, num_layer, num_output]

main :: IO ()
main = do
  -- Create a new ANN
  withStandardFann fannDef $ \fann -> do
    -- Replace the default activation function 'fannSigmoid' with
    -- a symmetric one
    setActivationFunctionHidden fann activationSigmoidSymmetric
    setActivationFunctionOutput fann activationSigmoidSymmetric
    algorithm <- getTrainingAlgorithm fann
    putStrLn $ show algorithm
    {-|
      trainIncremental = 0
      trainBatch       = 1
      trainRPROP       = 2
      trainQuickProp   = 3
     -}
    setTrainingAlgorithm fann trainQuickProp
    -- Train the ANN on the data from file \'or.data\'
    -- \'or.data'\ is OR gate input/output data
    let desired_error      = 0.001
        maxEpochs          = 500000
        epochBetweenReport = 1000
        learningrate       = 0.7
    setLearningRate fann learningrate
    dataPtr <- loadTrainData "or.data"
    let mininumBound = 0.0
        maximumBound = 1.0
    scaleInputTrainData dataPtr mininumBound maximumBound
    trainOnData fann dataPtr maxEpochs epochBetweenReport desired_error
    -- or using trainOnFile
    -- trainOnFile fann "or.data" maxEpochs epochBetweenReport desired_error
    mse <- getMSE fann
    putStrLn $ "MSE: " ++ show mse

    -- Save the trained ANN to file \'or.ann\'
    saveFann fann "or.ann"
