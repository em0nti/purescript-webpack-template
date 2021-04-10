{ name = "yomo"
, dependencies = [ "console", "effect", "psci-support", "web-dom", "web-html" ]
, packages = ./packages.dhall
, sources = [ "src/**/*.purs", "test/**/*.purs" ]
}
