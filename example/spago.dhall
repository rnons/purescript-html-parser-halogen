{ name = "example"
, dependencies =
  [ "aff"
  , "arrays"
  , "const"
  , "control"
  , "dom-indexed"
  , "maybe"
  , "prelude"
  , "transformers"
  , "effect"
  , "halogen"
  ]
, packages = ../packages.dhall
, sources = [ "../src/**/*.purs", "src/**/*.purs" ]
}
