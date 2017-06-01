{-
a toy database service to demonstrate composing modules.
-}

{-# LANGUAGE FlexibleInstances     #-}
{-# LANGUAGE GADTs                 #-}
{-# LANGUAGE MultiParamTypeClasses #-}

module Example.Database where

import           Example.Logger
import           Protolude

-- interface for using a database
class (Monad m) => Database m a where
    write :: a -> k -> Text -> m ()
    read :: a -> k -> m Text

-- constructor signature for a particular instance
data PrinterDatabase l where
    PrinterDatabase :: (Logger m l) => l -> PrinterDatabase l

-- concrete implementation for the constructor
instance (Monad m, Logger m l) => Database m (PrinterDatabase l) where
    write (PrinterDatabase l) key value =
        mlog l "called write"
    read (PrinterDatabase l) key = do
        mlog l "called read"
        pure "answer is 120"
