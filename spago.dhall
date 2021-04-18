{ name = "purescript-webpack-template"
, dependencies =
  [ "arrays"
  , "codec-argonaut"
  , "console"
  , "effect"
  , "halogen"
  , "maybe"
  , "prelude"
  , "profunctor"
  , "psci-support"
  , "strings"
  , "tuples"
  ]
, packages = ./packages.dhall
, sources = [ "src/**/*.purs", "test/**/*.purs" ]
}
