module Main where

import Utils.DataUtil
import qualified Data.ByteString.Lazy as L
import Network.HTTP.Simple
import Control.Monad.Cont
import Data.Aeson (Value)
import Views.ViewMain
import Models.DataJSON

main :: IO ()
main = do

    setupMainView

    res <- makeRequest

    case res of Left  x -> error x
                Right a -> print a
 
   
             
    
    
     