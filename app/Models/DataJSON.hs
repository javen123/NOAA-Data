{-# LANGUAGE DeriveGeneric #-}

module Models.DataJSON (NOAAData) where 

import qualified Data.Text as T
import Data.Aeson 
import GHC.Generics
import Control.Applicative (Alternative(empty))
import Data.Aeson.Types

data NOAAData = NOAAData {
      elevation :: Int 
    , latitude  :: Float
    , longitude :: Float
    , name      :: T.Text
} deriving (Show,Generic)



instance FromJSON NOAAData where
    