module Nashorn where


import Data.Unit (Unit)
import Effect

foreign import log :: String -> Effect Unit
