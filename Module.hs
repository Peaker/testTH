{-# LANGUAGE TemplateHaskell #-}
module Module(Foo, thFooFromDouble, doubleFromFoo, maybeFooFromDouble) where

import Language.Haskell.TH

newtype Foo = Foo Double
  deriving (Show)

doubleFromFoo :: Foo -> Double
doubleFromFoo (Foo x) = x

maybeFooFromDouble :: Double -> Maybe Foo
maybeFooFromDouble x
        | 0 <= x && x <= 1 = Just (Foo x)
        | otherwise        = Nothing

unsafeFooFromDouble :: Double -> Foo
unsafeFooFromDouble = Foo

thFooFromDouble :: (Real a, Show a) => a -> Q Exp
thFooFromDouble x
        | 0 <= x && x <= 1 = return $ AppE (VarE 'unsafeFooFromDouble)
                                           (LitE (RationalL (toRational x)))
        | otherwise        = fail $ show x ++ " is not between 0 and 1"
