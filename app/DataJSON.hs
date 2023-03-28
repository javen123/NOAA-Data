{-# LANGUAGE DeriveGeneric #-}

module DataJSON (NOAAData) where 

import qualified Data.Text as T
import qualified Data.Aeson as A
import GHC.Generics


data NOAAData = NOAAData {
      elevation :: Int 
    , latitude  :: Float
    , longitude :: Float
    , name      :: T.Text
} deriving (Show,Generic)

instance A.FromJSON NOAAData where
