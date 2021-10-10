{ name = "html-parser-halogen"
, dependencies =
  [ "arrays"
  , "bifunctors"
  , "control"
  , "dom-indexed"
  , "either"
  , "foldable-traversable"
  , "lists"
  , "strings"
  , "effect"
  , "halogen"
  , "prelude"
  , "psci-support"
  , "string-parsers"
  , "jest"
  ]
, packages = ./packages.dhall
, sources = [ "src/**/*.purs", "test/**/*.purs" ]
}
