{-
this is a clone of the Logger, but with a different name. present
to demonstrate multiple pieces constraining monad.
-}

{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE FunctionalDependencies #-}
{-# LANGUAGE GADTs #-}
{-# LANGUAGE FlexibleContexts #-}

module Example.Fwooper where

import Protolude

-- interface
class (Monad m) => Fwooper m a | a -> m where
    flog :: a -> Text -> m ()

-- constructor signature
data MagicFwooper m where
    MagicFwooper :: (Monad m) => MagicFwooper m

-- concrete implementation for constructor
instance (MonadReader Text m) => Fwooper m (MagicFwooper m) where
    flog f msg = undefined
