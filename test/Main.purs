module Test.Main where

import Prelude

import Data.Either (Either(..), isRight)
import Data.Foldable (sequence_)
import Data.List (List)
import Data.List as List
import Effect (Effect)
import Html.Parser (HtmlAttribute(..), HtmlNode(..), parse)
-- import Jest (expectToBeTrue, expectToEqual, test)

-- type Spec =
--   { name :: String
--   , raw :: String
--   , expected :: List HtmlNode
--   }

-- simpleATagLineBreak :: String
-- simpleATagLineBreak = """
-- <a
--   href="https://purescript.org"
--   target="blank_"
--   >purescript</a>
-- """

-- simpleATagExpected :: HtmlNode
-- simpleATagExpected = HtmlElement
--   { name: "a"
--   , attributes: List.fromFoldable
--       [ HtmlAttribute "href" "https://purescript.org"
--       , HtmlAttribute "target" "blank_"
--       ]
--   , children: List.singleton $ HtmlText "purescript"
--   }

-- specs :: Array Spec
-- specs =
--   [ { name: "plain text"
--     , raw: "abc"
--     , expected: List.singleton $ HtmlText "abc"
--     }
--   , { name: "simple <a> tag"
--     , raw: "<a href=\"https://purescript.org\" target=\"blank_\">purescript</a>"
--     , expected: List.singleton $ simpleATagExpected
--     }
--   , { name: "simple <a> tag with line break"
--     , raw: simpleATagLineBreak
--     , expected: List.fromFoldable $
--         [ HtmlText "\n"
--         , simpleATagExpected
--         , HtmlText "\n"
--         ]
--     }
--   , { name: "html entities"
--     , raw: "<div>a&amp;b</div>"
--     , expected: List.fromFoldable $
--         [ HtmlElement
--             { name: "div"
--             , attributes: List.Nil
--             , children: List.singleton $ HtmlText "a&b"
--             }
--         ]
--     }
--   , { name: "tag inside text"
--     , raw: "a <b>b</b> c"
--     , expected: List.fromFoldable
--         [ HtmlText "a "
--         , HtmlElement
--             { name: "b"
--             , attributes: List.Nil
--             , children: List.singleton $ HtmlText "b"
--             }
--         , HtmlText " c"
--         ]
--     }
--   , { name: "non breaking space"
--       -- The first character is a non breaking space (code point 160).
--     , raw: "  1234"
--     , expected: List.singleton $
--         HtmlText "  1234"
--     }
--   ]

-- rightHtml :: Array String
-- rightHtml =
--   [ "<iframe></iframe>"
--   , "<iframe width ></iframe>"
--   , "<iframe width src='//'></iframe>"
--   , """<iframe width ="560" ></iframe>"""
--   , "<iframe width='560' ></iframe>"
--   , """<iframe width = "560" ></iframe>"""
--   , "<iframe width='560' height='315' src='//www.youtube.com/embed/gE6j-Zp323w' frameborder='0' allowfullscreen></iframe>"
--   ]

-- main :: Effect Unit
-- main = do
--   sequence_ $ specs <#> \spec -> do
--     test spec.name $ expectToEqual (parse spec.raw) (Right spec.expected)

--   sequence_ $ rightHtml <#> \html -> do
--     test ("should parse right: " <> html) $
--       expectToBeTrue (isRight $ parse html)

main = pure unit