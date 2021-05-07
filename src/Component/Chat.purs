module Component.Chat where

import Prelude
import DOM.HTML.Indexed.InputType (InputType(InputText))
import Halogen (Component, ComponentHTML, HalogenM, defaultEval, mkComponent, mkEval, modify_)
import Halogen.HTML as H
import Halogen.HTML.Properties as P
import Halogen.HTML.Events as E
import Data.Maybe (Maybe(..), fromMaybe)
import Html (maybeElem)
import Effect.Class.Console (log)
import Effect.Class (class MonadEffect)

type State
  = { currentMessage :: Maybe String
    , sentMessage :: Maybe String
    }

data Action
  = Send
  | HandleInput String

component :: forall i o m q. MonadEffect m => Component q i o m
component =
  mkComponent
    { initialState: const { currentMessage: Nothing, sentMessage: Nothing }
    , render
    , eval: mkEval defaultEval { handleAction = handleAction }
    }
  where
  render :: State -> ComponentHTML Action () m
  render { currentMessage, sentMessage } =
    H.div_
      [ H.input
          [ P.type_ InputText
          , P.placeholder "Enter your message"
          , P.value (fromMaybe "" currentMessage)
          , E.onValueInput HandleInput
          ]
      , H.button [ E.onClick \_ -> Send ] [ H.text "Send" ]
      , maybeElem sentMessage \msg -> H.p_ [ H.text msg ]
      ]

  handleAction :: Action -> HalogenM State Action () o m Unit
  handleAction = case _ of
    Send -> do
      log "Send Action"
      modify_ \state ->
        state
          { currentMessage = Nothing
          , sentMessage = state.currentMessage
          }
    HandleInput value -> do
      log $ "HandledInput Action: " <> value
      modify_ $ _ { currentMessage = Just value }
