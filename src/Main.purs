module Main where

import Prelude
import Effect (Effect)
import Halogen.Aff (awaitBody, runHalogenAff)
import Halogen.VDom.Driver (runUI)
import Halogen as H
import Halogen.HTML as HH
import Halogen.HTML.Properties as HP
import Data.Maybe (Maybe(..))

-- import Halogen.Aff as HA
-- import Halogen.HTML.Events as HE
-- import Component.Rainbow as Rainbow
main :: Effect Unit
main =
  runHalogenAff do
    body <- awaitBody
    runUI component unit body

type State
  = Unit

component :: forall t20 t21 t35 t38. H.Component t35 t38 t20 t21
component =
  H.mkComponent
    { initialState
    , render
    , eval: H.mkEval $ H.defaultEval { handleAction = handleAction }
    }
  where
  initialState _ = unit

  render :: State -> HH.HTML _ _
  render _state =
    HH.div_
      [ -- <table>--   <tr>--     HH.td_ [ HH.text "Name" ]--     HH.td_ [ HH.text "Surname" ]
      --     HH.td_ [ HH.text "Nickname" ]
      --   </tr>
      --   <tr>
      --     <td>Vadym</td>
      --     <td>Shtabovenko</td>
      --     <td>Bodya Molekula</td>
      --   </tr>
      -- </table>
      ]
    where
    rows :: Array (Array (Maybe String))
    rows =
      [ [ Just "Name", Just "Surname", Just "Nickname" ]
      , [ Just "Yura", Just "Lazarev", Nothing ]
      , [ Just "Vadym", Just "Shtabovenko", Just "Bodya Molekula" ]
      , [ Just "Vlad", Just "Sorokolit", Just "Skipper" ]
      ]

  handleAction _action = pure unit

  cn = HP.class_ <<< H.ClassName

  -- Render the name, if there is one
  renderName :: forall w i. Maybe String -> HH.HTML w i
  renderName mbName = maybeElem mbName HH.text

  maybeElem :: forall w i a. Maybe a -> (a -> HH.HTML w i) -> HH.HTML w i
  maybeElem val f = case val of
    Just x -> f x
    Nothing -> HH.text ""

  whenElem :: forall w i. Boolean -> (Unit -> HH.HTML w i) -> HH.HTML w i
  whenElem cond f = case cond of
    true -> f unit
    false -> HH.text ""

  -- Render the old number, but only if it is different from the new number
  renderOld :: forall w i. { old :: Number, new :: Number } -> HH.HTML w i
  renderOld { old, new } =
    whenElem (old /= new) \_ ->
      HH.div_ [ HH.text $ show old ]
