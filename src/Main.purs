module Main where

import Prelude
import Data.Maybe (Maybe(..))
import Effect (Effect)
import Halogen as H
import Halogen.Aff (awaitBody, runHalogenAff)
import Halogen.HTML as HH
import Halogen.HTML.Properties as HP
import Halogen.VDom.Driver (runUI)
import Halogen.HTML.Events as HE

data Action
  = Increment
  | Decrement

-- import Halogen.Aff as HA
-- import Component.Rainbow as Rainbow
main :: Effect Unit
main =
  runHalogenAff do
    body <- awaitBody
    runUI root unit body

type State
  = Int

root :: forall i o m q. H.Component q i o m
root =
  H.mkComponent
    { initialState
    , render
    , eval: H.mkEval H.defaultEval { handleAction = handleAction }
    }
  where
  initialState :: i -> State
  initialState _ = 0

  render :: State -> H.ComponentHTML Action () m
  render state =
    HH.div_
      [ HH.button [ HE.onClick \_mouseEvt -> Decrement ] [ HH.text "Decrement" ]
      , HH.text (show state)
      , HH.button [ HE.onClick \_mouseEvt -> Increment ] [ HH.text "Increment" ]
      ]

  handleAction :: Action -> H.HalogenM State Action () o m Unit
  handleAction = case _ of
    Decrement -> H.modify_ (_ - 1)
    Increment -> H.modify_ (_ + 1)

  maybeElem :: forall w idx a. Maybe a -> (a -> HH.HTML w idx) -> HH.HTML w idx
  maybeElem val f = case val of
    Just x -> f x
    Nothing -> HH.text ""

  whenElem :: forall w idx. Boolean -> (Unit -> HH.HTML w idx) -> HH.HTML w idx
  whenElem cond f = case cond of
    true -> f unit
    false -> HH.text ""
