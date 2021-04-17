module Component.Rainbow (component) where

import Prelude
import Data.Array ((:))
import Data.Tuple (Tuple(..))
import Halogen as H
import Halogen.HTML as HH
import Halogen.HTML.Events as HE
import Data.String.CodeUnits as String

component :: ∀ q i o m. H.Component q i o m
component = H.mkComponent { initialState, render, eval }

data Color
  = Red
  | Green
  | Blue

nextColor :: Color -> Color
nextColor = case _ of
  Red -> Green
  Green -> Blue
  Blue -> Red

type State
  = Array (Tuple Char Color)

data Action
  = Repaint

initialState :: ∀ i. i -> State
initialState _ =
  [ Tuple 'G' Red
  , Tuple 'A' Green
  , Tuple 'Y' Blue
  ]

render :: ∀ slots m. State -> HH.HTML (H.ComponentSlot slots m Action) Action
render state = HH.div_ $ next : letters
  where
  next = HH.button [ HE.onClick \_ -> Repaint ] [ HH.text "Next" ]

  letters :: Array (HH.HTML (H.ComponentSlot slots m Action) Action)
  letters =
    state
      <#> \(Tuple letter color) ->
          HH.div_ [ HH.text (String.singleton letter) ]

eval ::
  ∀ query input output m a slots.
  H.HalogenQ query Action input a ->
  H.HalogenM State Action slots output m a
eval = H.mkEval $ H.defaultEval { handleAction = handleAction }
  where
  handleAction :: Action -> H.HalogenM State Action slots output m Unit
  handleAction Repaint = H.modify_ (map (map nextColor))
