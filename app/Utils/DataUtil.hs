{-# LANGUAGE OverloadedStrings
, FlexibleContexts #-}

module Utils.DataUtil (makeRequest) where 

import qualified Data.ByteString.Char8 as BC
import qualified Data.ByteString.Lazy as L
import Network.HTTP.Simple
import Control.Monad.IO.Class
import Models.DataJSON
import Data.Aeson

import Debug.Trace
import Data.Aeson.Types (parseEither)


myToken :: BC.ByteString
myToken = BC.pack "OKwlqqpFYrOdSUkTrrvwgMfmumXJzUlT"

noaaHost :: String
noaaHost = "https://www.ncei.noaa.gov/cdo-web/api/v2"

pathApi :: String
pathApi = "/stations?locationid=FIPS:08117&datatypeid=SNOW&limit=50&startdate=2023-03-01"

buildRequest :: BC.ByteString -> String ->
        String -> Request
buildRequest token host path = 
    setRequestHeader "token" [token]
    $ setRequestSecure True 
    $ parseRequest_ ("GET " ++ host ++ path)

makeRequest :: MonadIO m => m (Either String NOAADataArray)
makeRequest = do
    response <- httpLBS $ buildRequest myToken noaaHost pathApi
    return (eitherDecode $ getResponseBody response :: Either String NOAADataArray)
    