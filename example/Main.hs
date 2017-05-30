{-# LANGUAGE OverloadedStrings     #-}

import Protolude
import Example.Program as E

-- this is a trivial main to call the program
main :: IO ()
main = runReaderT E.program "some text"
