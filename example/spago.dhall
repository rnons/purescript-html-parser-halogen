{ name = "example"
, dependencies =
  [ "aff"
  , "arrays"
  , "bifunctors"
  , "const"
  , "control"
  , "dom-indexed"
  , "either"
  , "lists"
  , "prelude"
  , "strings"
  , "transformers"
  , "effect"
  , "halogen"
  , "string-parsers"
  ]
, packages = ../packages.dhall
, sources = [ "../src/**/*.purs", "src/**/*.purs" ]
}
