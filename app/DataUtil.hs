{-# LANGUAGE OverloadedStrings #-}

module DataUtil (requestResponse) where 

import qualified Data.ByteString.Char8 as BC
import qualified Data.ByteString.Lazy as L
import Network.HTTP.Simple 
import Control.Monad.IO.Class

myToken :: BC.ByteString
myToken = BC.pack "OKwlqqpFYrOdSUkTrrvwgMfmumXJzUlT"

noaaHost :: String
noaaHost = "https://www.ncei.noaa.gov/cdo-web/api/v2"

pathApi :: String
pathApi = "/stations"

buildRequest :: BC.ByteString -> String ->
        String -> Request
buildRequest token host path = 
    setRequestHeader "token" [token]
    $ setRequestSecure True 
    $ parseRequest_ ("GET " ++ host ++ path)

request :: Request
request = buildRequest myToken noaaHost pathApi

requestResponse :: IO ()
requestResponse = 
    httpLBS request >>= \res ->
        httpLBS request >>= \response ->
        let code = getResponseStatusCode response 
        in if code == 200 
            then 
                let body = getResponseBody response 
                in L.writeFile "data1.json" body
            else print "Error writing file"