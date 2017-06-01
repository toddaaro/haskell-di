{-
a demo of how to do smd code in haskell. example is a fake compute service.
-}

{-# LANGUAGE FlexibleInstances     #-}
{-# LANGUAGE GADTs                 #-}
{-# LANGUAGE MultiParamTypeClasses #-}

module Example.Program where

import           Example.Database
import           Example.Fwooper
import           Example.Logger
import           Example.Service
import           Protolude

{-
finally wire the dependencies and call the top level entry.
note that we don't need to specify any types manually, everything
is correctly inferred from the monad type on program. this is
particularly cool as both logger and fwooper depend on the monad,
and have different expectations of it, and those expectations
are correctly unified.
-}
program :: ReaderT Text IO ()
program = do
    let logger = PrintLogger
        database = PrinterDatabase logger
        fwooper = MagicFwooper
        service = MegaBrain logger database fwooper

    thinkHard service

{-
as this is supposed to be a modular system, here is an example of
an alternate logger. the default uses printStrLn in IO, this is
just a noop that throws away the content.
-}

data UndefinedLogger m where
    UndefinedLogger :: (Monad m) => UndefinedLogger m

instance (Monad m) => Logger m (UndefinedLogger m) where
    mlog l msg = pure ()

programTwo :: (Reader Text) ()
programTwo = do
    let logger = UndefinedLogger
        fwooper = MagicFwooper
        database = PrinterDatabase logger
        service = MegaBrain logger database fwooper

    thinkHard service
