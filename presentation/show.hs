{-
Example of how a typeclass works
ghc -o show show.hs && ./show
-}
-- Display typeclass
class Display a where
    display :: a -> String

-- Instance of Display for an integer
instance Display Int where
    display x = "Int: " ++ show x

-- Instance of Display for a boolean
instance Display Bool where
    display True  = "Bool: True"
    display False = "Bool: False"

-- Main function
main :: IO ()
main = do
    let num :: Int  -- Explicitly declare num as Int
        num = 12
    let t = True
    let f = False
    -- Print out each using the display typeclass
    putStrLn (display num)
    putStrLn (display t)
    putStrLn (display f)
