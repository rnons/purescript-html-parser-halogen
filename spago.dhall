{ name = "html-parser-halogen"
, dependencies =
  [ "arrays"
  , "control"
  , "dom-indexed"
  , "foldable-traversable"
  , "effect"
  , "halogen"
  , "maybe"
  , "prelude"
  , "psci-support"
  , "jest"
  ]
, packages = ./packages.dhall
, sources = [ "src/**/*.purs", "test/**/*.purs" ]
}
