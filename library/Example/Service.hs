{-
a more complex toy compute service to demonstrate composing modules.
-}

{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE GADTs #-}

module Example.Service where

import Protolude
import Example.Logger
import Example.Database
import Example.Fwooper

-- interface
class (Monad m) => HardLogicService m a where
    thinkHard :: a -> m ()

-- constructor for implementation
data MegaBrain l d f where
    MegaBrain :: (Logger m l, Database m d, Fwooper m f) => l -> d -> f -> MegaBrain l d f

-- implementation for implementation
instance (Monad m, Logger m l, Database m d, Fwooper m f) => HardLogicService m (MegaBrain l d f) where
    thinkHard (MegaBrain l d f) = do
        v <- read d "a key"
        mlog l v
        write d "different key" "a value"
