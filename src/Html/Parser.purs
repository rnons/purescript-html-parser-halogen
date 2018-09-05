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
import Data.Generic.Rep (class Generic)
import Data.Generic.Rep.Show (genericShow)
import Data.List (List)
import Data.List as List
import Data.String.CodeUnits (fromCharArray)
import Text.Parsing.StringParser (Parser, ParseError, runParser, try)
import Text.Parsing.StringParser.Combinators (many, manyTill, option, optional, sepEndBy)
import Text.Parsing.StringParser.CodeUnits (anyChar, regex, skipSpaces, string, whiteSpace)

data HtmlNode
  = HtmlElement Element
  | HtmlText String
  | HtmlComment String

derive instance genericRepHtmlNode :: Generic HtmlNode _
instance showHtmlNode :: Show HtmlNode where show = defer \_ -> genericShow

type Element =
  { name :: String
  , attributes :: List HtmlAttribute
  , children :: List HtmlNode
  }

data HtmlAttribute = HtmlAttribute String String

derive instance genericRepHtmlAttribute :: Generic HtmlAttribute _
instance showHtmlAttribute :: Show HtmlAttribute where show = genericShow

mkElement :: String -> List HtmlAttribute -> List HtmlNode -> Element
mkElement =
  { name: _
  , attributes: _
  , children: _
  }

charListToString :: List Char -> String
charListToString = fromCharArray <<< Array.fromFoldable

attributeParser :: Parser HtmlAttribute
attributeParser = do
  k <- regex "[^=>/]+"
  v <- option "" (string "=\"" *> regex "[^\"]*" <* string "\"")
  pure $ HtmlAttribute k v

openingParser :: Parser Element
openingParser = do
  _ <- string "<"
  tagName <- regex "[^/> ]+"
  attributes <- whiteSpace *> sepEndBy attributeParser whiteSpace
  pure $ mkElement tagName attributes List.Nil

selfClosingTags :: Array String
selfClosingTags =
  [ "br", "img", "hr", "meta", "input", "embed", "area", "base", "col"
  , "keygen", "link", "param", "source", "command", "link", "track", "wbr"
  ]

isSelfClosingElement :: Element -> Boolean
isSelfClosingElement ele = ele.name `Array.elem` selfClosingTags

closingOrChildrenParser :: Element -> Parser Element
closingOrChildrenParser element = defer \_ ->
  if isSelfClosingElement element
  then whiteSpace *> optional (string "/") *> string ">" *> pure element
  else childrenParser
  where
    childrenParser = do
      _ <- whiteSpace *> string ">"
      children <- manyTill nodeParser
                 (string ("</" <> element.name <> ">"))
      pure $ element { children = children }

elementParser :: Parser HtmlNode
elementParser = defer \_ -> do
  skipSpaces
  openingParser >>=
    closingOrChildrenParser >>=
    pure <<< HtmlElement

textParser :: Parser HtmlNode
textParser = HtmlText <$> regex "[^<]+"

commentParser :: Parser HtmlNode
commentParser = do
  skipSpaces
  comment <- string "<!--" *> manyTill anyChar (string "-->")
  pure $ HtmlComment $ charListToString comment

nodeParser :: Parser HtmlNode
nodeParser = defer \_ ->
  try textParser <|>
  try commentParser <|>
  elementParser

parse :: String -> Either ParseError (List HtmlNode)
parse input =
  runParser (many nodeParser) input
