{-# LANGUAGE DeriveGeneric 
  , OverloadedStrings #-}
{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Use newtype instead of data" #-}

module Models.DataJSON (NOAADataArray) where 

import qualified Data.Text as T
import Data.Aeson 
import GHC.Generics
import Control.Applicative (Alternative(empty))
import Data.Aeson.Types

data NOAAData = NOAAData {
      elevation :: Float 
    , latitude  :: Float
    , longitude :: Float
    , name      :: T.Text
} deriving (Show,Generic)

newtype NOAADataArray = NOAADataArray {getNOAAArray :: [NOAAData]} deriving (Show, Generic)

instance FromJSON NOAAData where

instance FromJSON NOAADataArray where
  parseJSON = withObject "" $ \o ->
    NOAADataArray <$> o .: "results"