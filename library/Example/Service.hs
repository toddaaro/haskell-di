{-
a more complex toy compute service to demonstrate composing modules.
-}

{-# LANGUAGE FlexibleInstances     #-}
{-# LANGUAGE GADTs                 #-}
{-# LANGUAGE MultiParamTypeClasses #-}

module Example.Service where

import           Example.Database
import           Example.Fwooper
import           Example.Logger
import           Protolude

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
