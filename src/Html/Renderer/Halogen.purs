module Html.Renderer.Halogen
  ( htmlAttributeToProp
  , elementToHtml
  , nodeToHtml
  , parse
  , render_
  , render
  , renderToArray
  ) where

import Prelude

import Data.Array as Array
import Data.List as List
import Data.Bifunctor (lmap)
import Data.Either (Either, either)
import Data.Maybe (maybe, Maybe(Just, Nothing))
import DOM.HTML.Indexed (HTMLdiv)
import Halogen.HTML as HH
import Halogen.HTML.Properties as HP
import Html.Parser (HtmlNode(..), HtmlAttribute(..), Element)
import Html.Parser as Parser

htmlAttributeToProp :: forall r i. HtmlAttribute -> HP.IProp r i
htmlAttributeToProp (HtmlAttribute k v) = HP.attr (HH.AttrName k) v

elementToHtml :: forall p i. Maybe HH.Namespace -> Element -> HH.HTML p i
elementToHtml maybeNs ele = insertElem (HH.ElemName ele.name) attrs children
  where
  newNs = case ele.name of
    "svg" -> Just $ HH.Namespace "http://www.w3.org/2000/svg"
    _ -> maybeNs
  insertElem = maybe HH.element HH.elementNS newNs
  attrs = (Array.fromFoldable $ map htmlAttributeToProp ele.attributes)
  children = Array.fromFoldable $ nodeToHtml newNs <$> ele.children

nodeToHtml :: forall p i. Maybe HH.Namespace -> HtmlNode -> HH.HTML p i
nodeToHtml maybeNs (HtmlElement ele) = elementToHtml maybeNs ele
nodeToHtml maybeNs (HtmlText str) = HH.text str
nodeToHtml maybeNs (HtmlComment _) = HH.text ""

parse :: forall p i. String -> Either String (Array (HH.HTML p i))
parse raw =
  lmap show $ (Array.fromFoldable <<< map (nodeToHtml Nothing)) <$> Parser.parse raw

render_ :: forall p i. String -> HH.HTML p i
render_ = render []

render :: forall p i. Array (HH.IProp HTMLdiv i) -> String -> HH.HTML p i
render props = HH.div props <<< renderToArray

renderToArray :: forall p i. String -> Array (HH.HTML p i)
renderToArray raw =
  either (\err -> [ HH.text err ]) identity (parse raw)
