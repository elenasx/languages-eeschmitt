{-
Program to demonstrate Maybe monad
Maybe monad has two possible values:
Just: value
Nothing: no value 
-}
-- Function to divide two integers
divideNumber :: Int -> Int -> Maybe Int
divideNumber x 0 = Nothing
divideNumber x y = Just (x `div` y)

-- Chain for Maybe to get result
result :: Maybe Int
result x y = do
    z <- divideNumber x y

-- Main function
main :: IO ()
    putStrLn "Enter a number: "
    num1 <- getLine
    putStrLn "Enter a number: "
    num2 <- getLine

    -- Convert into numbers
    let x = read num1 :: Int
        y = read num2 :: Int

    -- Divide the numbers and print result
    let res = result x y
    case res of 
        Just value -> putStrLn $ "Result: " ++ show value
        Nothing -> putStrLn "Incorrect input or divided by 0."