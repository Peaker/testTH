{-# LANGUAGE TemplateHaskell #-}
import Module

main = do
  print $(thFooFromDouble 0.5)
