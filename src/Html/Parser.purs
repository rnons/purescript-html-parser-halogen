module Html.Parser
  ( HtmlNode(..)
  , Element(..)
  , HtmlAttribute(..)
  , parse
  ) where

import Prelude

import Control.Alt ((<|>))
import Control.Lazy (defer)
import Data.Array as Array
import Data.Either (Either)
import Data.List (List)
import Data.List as List
import Data.String.CodeUnits (fromCharArray)
import StringParser (Parser, ParseError, runParser, try)
import StringParser.CodeUnits (anyChar, regex, skipSpaces, string, whiteSpace)
import StringParser.Combinators (many, manyTill, option, optional, sepEndBy)

data HtmlNode
  = HtmlElement Element
  | HtmlText String
  | HtmlComment String

derive instance eqHtmlNode :: Eq HtmlNode

type Element =
  { name :: String
  , attributes :: Array HtmlAttribute
  , children :: Array HtmlNode
  }

data HtmlAttribute = HtmlAttribute String String

derive instance eqHtmlAttribute :: Eq HtmlAttribute

foreign import parseFromString
  :: (Element -> HtmlNode)
  -> (String -> String -> HtmlAttribute)
  -> (String -> HtmlNode)
  -> (String -> HtmlNode)
  -> String
  -> Array HtmlNode

parse :: String -> Array HtmlNode
parse input =
  parseFromString HtmlElement HtmlAttribute HtmlText HtmlComment input
