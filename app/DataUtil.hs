{-# LANGUAGE OverloadedStrings
, FlexibleContexts #-}


module DataUtil (fetchData) where 

import qualified Data.ByteString.Char8 as BC
import qualified Data.ByteString.Lazy as L
import Network.HTTP.Simple 
import Control.Monad.IO.Class
import DataJSON
import Data.Aeson
-- import Control.Error


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

request :: Request
request = buildRequest myToken noaaHost pathApi

fetchData :: Either String NOAAData
fetchData = 
    httpJSON request >>= \r -> 
    if getResponseStatusCode r == 200 
        then eitherDecode $ getResponseBody r
        else Left "Bad URL request"
        