{ name = "html-parser-halogen"
, dependencies =
  [ "arrays"
  , "control"
  , "dom-indexed"
  , "effect"
  , "either"
  , "foldable-traversable"
  , "halogen"
  , "jest"
  , "lists"
  , "maybe"
  , "prelude"
  , "string-parsers"
  , "strings"
  ]
, packages = ./packages.dhall
, sources = [ "src/**/*.purs", "test/**/*.purs" ]
}
