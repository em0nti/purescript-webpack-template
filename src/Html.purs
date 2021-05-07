module Html where

import Prelude
import Data.Maybe (Maybe(..))
import Halogen.HTML (HTML, text)

maybeElem :: forall w i a. Maybe a -> (a -> HTML w i) -> HTML w i
maybeElem val f = case val of
  Just x -> f x
  Nothing -> text ""

whenElem :: forall w i. Boolean -> (Unit -> HTML w i) -> HTML w i
whenElem cond f = case cond of
  true -> f unit
  false -> text ""
