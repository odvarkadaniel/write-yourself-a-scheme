module Main where

import System.Environment (getArgs)

main = do
  args <- (read <$>) <$> getArgs
  print ("Sum: " ++ show (head args + (args !! 1)))
