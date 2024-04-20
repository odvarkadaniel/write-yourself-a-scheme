{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE OverloadedStrings #-}

module LispVal where

import Control.Monad.Except
import Control.Monad.Reader
import Data.Map qualified as Map
import Data.Text as T

type CtxEnv = Map.Map T.Text LispVal

newtype Eval a = Eval {unEval :: ReaderT CtxEnv IO a}
  deriving
    ( Monad,
      Functor,
      Applicative,
      MonadReader CtxEnv,
      MonadIO
    )

data LispVal
  = Atom T.Text
  | List [LispVal]
  | Number Integer
  | String T.Text
  | Func IFunc
  | Lambda IFunc CtxEnv
  | Nil
  | Bool Bool
  deriving (Eq)

newtype IFunc = IFunc {fn :: [LispVal] -> Eval LispVal}

instance Eq IFunc where
  (==) _ _ = False

instance Show LispVal where
  show = T.unpack . showVal

showVal :: LispVal -> T.Text
showVal val = case val of
  (Atom atom) -> atom
  (List l) -> T.concat ["(", T.unwords $ showVal <$> l, ")"]
  (Number i) -> T.pack $ show i
  (String str) -> T.concat ["\"", str, "\""]
  (Func _) -> "internal_f"
  (Lambda _ _) -> "lambda_f"
  Nil -> "Nil"
  (Bool True) -> "#t"
  (Bool False) -> "#f"
