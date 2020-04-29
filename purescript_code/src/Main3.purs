module Main3 where

import Nashorn (log) as Nashorn
import Prelude (Unit, bind, discard, pure, show, ($), (+), (<>), (==)) 
import Data.Either (Either)
import Data.Tuple (Tuple)
import Data.Newtype (class Newtype, unwrap)
import Control.Monad.Except.Trans (ExceptT, runExceptT, throwError)
import Control.Monad.State (State, StateT, modify, runStateT) 
import Control.Monad.State.Class (get, put)

import Control.Monad.Writer (lift)
import Control.Monad.Writer.Class (tell)
import Control.Monad.Writer.Trans (WriterT, runWriterT)
import Data.Identity (Identity)
import Data.String (drop, take)
import Effect (Effect)
import Data.Foldable (traverse_)
import Control.MonadZero (guard)
import Data.String.Common (toUpper,toLower)
import Data.Array (some)
import Control.Alt((<|>))


type Errors = Array String
type Log = Array String
type Parser = StateT String (WriterT Log (ExceptT Errors Identity))
split2 :: Parser String
split2 = do
  s <- get
  lift $ tell ["The state is " <> s]
  case s of
    "" -> lift $ lift $ throwError ["Empty string"]
    _ -> do
      put (drop 1 s)
      pure (take 1 s)
-- runParser :: forall t109 t116 t117 t122 t123 t125. Newtype (t116 (Either t117 (Tuple (Tuple t123 t125) t122))) t109 => StateT t125 (WriterT t122 (ExceptT t117 t116)) t123 -> t125 -> t109
runParser :: forall t60 t67 t68 t73 t74 t76. Newtype (t67 (Either t68 (Tuple (Tuple t74 t76) t73))) t60 => StateT t76 (WriterT t73 (ExceptT t68 t67)) t74 -> t76 -> t60
runParser p s = unwrap $ runExceptT $ runWriterT $ runStateT p s

upper :: Parser String
upper = do
  s <- split2
  guard $ toUpper s == s
  pure s


-- safeDivide a b =  do
--   case b of
--     0 ->  throwError ["Empty string"]
--     n -> a / n

sumArray :: Array Int -> (State Int) Unit
sumArray array = traverse_ ( \n -> modify (\sum -> sum + n ) ) array

main :: Effect Unit
main = do 
  -- log $ show $ runParser ((<>) <$> split2 <*> split2) "test"
  -- log $ show $ runParser (upper) "TEst"
  -- log $ show $ runParser (many upper) "test"
  -- log $ show $ runParser (some upper) "test"
  Nashorn.log $ show $ runParser (some upper <|> some lower) "teST" 
  Nashorn.log $ show $ runParser (some upper <|> some lower) "TEst"
    
    
  -- log $ show $  execState (do
  --   sumArray [1, 2, 3]
  --   sumArray [4, 5]
  --   sumArray [6]) 0 
  -- log $ show $  runState (sumArray [1, 2, 3]) 0 

lower :: Parser String
lower = do
  s <- split2
  guard $ toLower s == s
  pure s 


  