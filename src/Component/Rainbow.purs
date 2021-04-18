module Component.Rainbow (component) where

import Prelude
import Data.Array as Array
import Data.String.CodeUnits as String
import Data.Tuple (Tuple(..))
import Halogen as H
import Halogen.HTML as HH
import Halogen.HTML.Events as E
import Halogen.HTML.Properties as P

component :: ∀ q o m. H.Component q Input o m
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

type Input
  = String

type State
  = Array (Tuple Char Color)

data Action
  = Repaint

initialState :: Input -> State
initialState letters =
  _.state
    $ Array.foldl colorize { state: [], color: Red }
    $ String.toCharArray letters
  where
  colorize acc c = { state: Array.snoc acc.state (Tuple c color), color }
    where
    color = nextColor acc.color

render :: ∀ slots m. State -> HH.HTML (H.ComponentSlot slots m Action) Action
render state =
  HH.div
    [ P.classes
        [ cn "flex"
        , cn "flex-col"
        , cn "h-screen"
        , cn "justify-center"
        ]
    ]
    [ HH.div
        [ P.classes
            [ cn "container"
            , cn "flex"
            , cn "flex-row"
            , cn "content-center"
            , cn "items-center"
            , cn "justify-evenly"
            , cn "space-x-4"
            , cn "mx-auto"
            ]
        ]
        letters
    , HH.div
        [ P.classes
            [ cn "flex"
            , cn "justify-center"
            , cn "my-5"
            , cn "underline"
            ]
        ]
        [ next ]
    ]
  where
  next =
    HH.button [ P.classes [], E.onClick \_ -> Repaint ]
      [ HH.text "REPAINT" ]

  letters :: Array (HH.HTML (H.ComponentSlot slots m Action) Action)
  letters =
    state
      <#> \(Tuple letter color) ->
          HH.div
            [ P.classes
                [ colorClass color
                , cn "font-sans"
                , cn "font-black"
                , cn "text-5xl"
                , cn "text-white"
                , cn "uppercase"
                , cn "shadow-xl"
                , cn "rounded-full"
                , cn "w-24"
                , cn "h-24"
                , cn "flex"
                , cn "justify-center"
                , cn "items-center"
                ]
            ]
            [ HH.text (String.singleton letter) ]

  cn = H.ClassName

  colorClass :: Color -> H.ClassName
  colorClass color =
    cn case color of
      Red -> "bg-red-500"
      Green -> "bg-green-500"
      Blue -> "bg-blue-500"

eval ::
  ∀ query input output m a slots.
  H.HalogenQ query Action input a ->
  H.HalogenM State Action slots output m a
eval = H.mkEval $ H.defaultEval { handleAction = handleAction }
  where
  handleAction :: Action -> H.HalogenM State Action slots output m Unit
  handleAction Repaint = H.modify_ (map (map nextColor))
