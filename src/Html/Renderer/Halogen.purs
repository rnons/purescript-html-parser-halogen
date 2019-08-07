module Html.Renderer.Halogen
  ( htmlAttributeToProp
  , elementToHtml
  , nodeToHtml
  , parse
  , render
  ) where

import Prelude

import Data.Array as Array
import Data.Bifunctor (lmap)
import Data.Either (Either, either)
import Halogen.HTML (HTML, ElemName(ElemName), element)
import Halogen.HTML as HH
import Halogen.HTML.Properties as HP
import Html.Parser (HtmlNode(..), HtmlAttribute(..), Element)
import Html.Parser as Parser

htmlAttributeToProp :: forall r i. HtmlAttribute -> HP.IProp r i
htmlAttributeToProp (HtmlAttribute k v) = HP.attr (HH.AttrName k) v

elementToHtml :: forall p i. Element -> HTML p i
elementToHtml ele =
  element (ElemName ele.name) (Array.fromFoldable $ map htmlAttributeToProp ele.attributes) children
  where
    children = Array.fromFoldable $ nodeToHtml <$> ele.children

nodeToHtml :: forall p i. HtmlNode -> HTML p i
nodeToHtml (HtmlElement ele) = elementToHtml ele
nodeToHtml (HtmlText str) = HH.text str
nodeToHtml (HtmlComment str) = HH.text ""

parse :: forall p i. String -> Either String (Array (HTML p i))
parse raw =
  lmap show $ (Array.fromFoldable <<< map nodeToHtml) <$> Parser.parse raw

render :: forall p i. String -> HTML p i
render raw = HH.div_ $
  either (\err -> [ HH.text err ]) identity (parse raw)
