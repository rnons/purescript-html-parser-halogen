module Html.Renderer.Halogen
  ( htmlAttributeToProp
  , elementToHtml
  , nodeToHtml
  , render_
  , render
  , renderToArray
  ) where

import Prelude

import Data.Array as Array
import DOM.HTML.Indexed (HTMLdiv)
import Halogen.HTML as HH
import Halogen.HTML.Properties as HP
import Html.Parser (HtmlNode(..), HtmlAttribute(..), Element)
import Html.Parser as Parser

htmlAttributeToProp :: forall r i. HtmlAttribute -> HP.IProp r i
htmlAttributeToProp (HtmlAttribute k v) = HP.attr (HH.AttrName k) v

elementToHtml :: forall p i. Element -> HH.HTML p i
elementToHtml ele =
  HH.element
    (HH.ElemName ele.name)
    (Array.fromFoldable $ map htmlAttributeToProp ele.attributes)
    children
  where
    children = Array.fromFoldable $ nodeToHtml <$> ele.children

nodeToHtml :: forall p i. HtmlNode -> HH.HTML p i
nodeToHtml (HtmlElement ele) = elementToHtml ele
nodeToHtml (HtmlText str) = HH.text str
nodeToHtml (HtmlComment _) = HH.text ""

render_ :: forall p i. String -> HH.HTML p i
render_ = render []

render :: forall p i. Array (HH.IProp HTMLdiv i) -> String -> HH.HTML p i
render props = HH.div props <<< renderToArray

renderToArray :: forall p i. String -> Array (HH.HTML p i)
renderToArray raw = map nodeToHtml $ Parser.parse raw
