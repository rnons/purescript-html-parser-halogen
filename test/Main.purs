module Test.Main where

import Prelude

import Data.Array as Array
import Data.Foldable (sequence_)
import Effect (Effect)
import Html.Parser (HtmlAttribute(..), HtmlNode(..), parse)
import Jest (expectToBeTrue, expectToEqual, test)

type Spec =
  { name :: String
  , raw :: String
  , expected :: Array HtmlNode
  }

simpleATagExpected :: HtmlNode
simpleATagExpected = HtmlElement
  { name: "a"
  , attributes:
      [ HtmlAttribute "href" "https://purescript.org"
      , HtmlAttribute "target" "blank_"
      ]
  , children: [HtmlText "purescript"]
  }

specs :: Array Spec
specs =
  [ { name: "plain text"
    , raw: "abc"
    , expected: [HtmlText "abc"]
    }
  , { name: "simple <a> tag"
    , raw: "<a href=\"https://purescript.org\" target=\"blank_\">purescript</a>"
    , expected: [simpleATagExpected]
    }
  , { name: "html entities"
    , raw: "<div>a&amp;b</div>"
    , expected:
        [ HtmlElement
            { name: "div"
            , attributes: []
            , children: [HtmlText "a&b"]
            }
        ]
    }
  , { name: "tag inside text"
    , raw: "a <b>b</b> c"
    , expected:
        [ HtmlText "a "
        , HtmlElement
            { name: "b"
            , attributes: []
            , children: [HtmlText "b"]
            }
        , HtmlText " c"
        ]
    }
  , { name: "non breaking space"
      -- The first character is a non breaking space (code point 160).
    , raw: "  1234"
    , expected: [HtmlText "  1234"]
    }
  , { name: "<script> tag"
    , raw: "<script>a<b>c</script>"
    , expected:
        [ HtmlElement
          { name: "script"
          , attributes: []
          , children: [HtmlText "a<b>c"]
          }
        ]
    }
  ]

rightHtml :: Array String
rightHtml =
  [ "<iframe></iframe>"
  , "<iframe width ></iframe>"
  , "<iframe width src='//'></iframe>"
  , """<iframe width ="560" ></iframe>"""
  , "<iframe width='560' ></iframe>"
  , """<iframe width = "560" ></iframe>"""
  , "<iframe width='560' height='315' src='//www.youtube.com/embed/gE6j-Zp323w' frameborder='0' allowfullscreen></iframe>"
  ]

main :: Effect Unit
main = do
  sequence_ $ specs <#> \spec -> do
    test spec.name $ expectToEqual (parse spec.raw) spec.expected

  sequence_ $ rightHtml <#> \html -> do
    test ("should parse right: " <> html) $
      expectToBeTrue $ Array.length (parse html) > 0
