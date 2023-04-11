
module Views.ViewMain (setupMainView) where 

import System.Console.ANSI
import qualified Data.Text as T
import Data.Maybe (fromJust)
type Point = (Int, Int)
type Size  = (Int, Int)

getSize :: IO Size 
getSize = fromJust <$> getTerminalSize

setupMainView :: IO ()
setupMainView = do
    getSize
    return ()