module Main where

main = do
    putStrLn "What is your name?"
    getLine >>= putStrLn . (++) "Hello, "
