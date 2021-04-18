module Main where

import Prelude
import Effect (Effect)
import Halogen.Aff (awaitBody, runHalogenAff)
import Halogen.VDom.Driver (runUI)
import Component.Rainbow as Rainbow

main :: Effect Unit
main =
  runHalogenAff do
    body <- awaitBody
    runUI Rainbow.component "colors" body
