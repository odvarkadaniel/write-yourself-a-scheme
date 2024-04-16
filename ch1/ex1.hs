module Main where

import System.Environment (getArgs)

main = do
  args <- getArgs
  if length args < 2 then putStrLn "Need atleast 2 arguments" else putStrLn ("Hello, " ++ head args ++ args !! 1 ++ "!")
