{-
lowest level leaf module for our toy modularity example.
-}

{-# LANGUAGE FlexibleInstances      #-}
{-# LANGUAGE FunctionalDependencies #-}
{-# LANGUAGE GADTs                  #-}
{-# LANGUAGE MultiParamTypeClasses  #-}

module Example.Logger where

import           Protolude

-- interface for writing a log statement
class (Monad m) => Logger m a | a -> m where
    mlog :: a -> Text -> m ()

-- constructor signature
data PrintLogger m where
    PrintLogger :: (Monad m) => PrintLogger m

-- concrete implementation for constructor
instance (MonadIO m) => Logger m (PrintLogger m) where
    mlog l = putStrLn
