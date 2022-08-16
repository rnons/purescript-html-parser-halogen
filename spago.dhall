{ name = "html-parser-halogen"
, license = "BSD-3-Clause"
, repository = "https://github.com/rnons/purescript-html-parser-halogen.git"
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
