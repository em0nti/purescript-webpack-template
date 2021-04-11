{ name = "purescript-webpack-template"
, dependencies =
  [ "console"
  , "effect"
  , "maybe"
  , "prelude"
  , "psci-support"
  , "web-dom"
  , "web-html"
  ]
, packages = ./packages.dhall
, sources = [ "src/**/*.purs", "test/**/*.purs" ]
}
