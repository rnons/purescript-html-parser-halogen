module Test.Main where

import Prelude

import Data.Either (Either(..))
import Data.Foldable (sequence_)
import Data.List (List)
import Data.List as List
import Effect (Effect)
import Html.Parser (HtmlAttribute(..), HtmlNode(..), parse)
import Jest (expectToEqual, test)

type Spec =
  { name :: String
  , raw :: String
  , expected :: List HtmlNode
  }

simpleATagLineBreak :: String
simpleATagLineBreak = """
<a
  href="https://purescript.org"
  target="blank_"
  >purescript</a>
"""

simpleATagExpected :: HtmlNode
simpleATagExpected = HtmlElement
  { name: "a"
  , attributes: List.fromFoldable
      [ HtmlAttribute "href" "https://purescript.org"
      , HtmlAttribute "target" "blank_"
      ]
  , children: List.singleton $ HtmlText "purescript"
  }

specs :: Array Spec
specs =
  [ { name: "plain text"
    , raw: "abc"
    , expected: List.singleton $ HtmlText "abc"
    }
  , { name: "simple <a> tag"
    , raw: "<a href=\"https://purescript.org\" target=\"blank_\">purescript</a>"
    , expected: List.singleton $ simpleATagExpected
    }
  , { name: "simple <a> tag with line break"
    , raw: simpleATagLineBreak
    , expected: List.fromFoldable $
        [ HtmlText "\n"
        , simpleATagExpected
        , HtmlText "\n"
        ]
    }
  ]

main :: Effect Unit
main = do
  sequence_ $ specs <#> \spec -> do
    test spec.name $ expectToEqual (parse spec.raw) (Right spec.expected)
