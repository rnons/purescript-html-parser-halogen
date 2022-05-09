module Html.Renderer.Halogen
  ( htmlAttributeToProp
  , elementToHtml
  , nodeToHtml
  , render_
  , render
  , renderToArray
  ) where

import Prelude

import Control.Alt ((<|>))
import DOM.HTML.Indexed (HTMLdiv)
import Data.Array as Array
import Data.Maybe (Maybe(..))
import Halogen.HTML as HH
import Halogen.HTML.Properties as HP
import Html.Parser (HtmlNode(..), HtmlAttribute(..), Element, parse)

htmlAttributeToProp :: forall r i. HtmlAttribute -> HP.IProp r i
htmlAttributeToProp (HtmlAttribute k v) = HP.attr (HH.AttrName k) v

elementToHtml :: forall p i. Maybe HH.Namespace -> Element -> HH.HTML p i
elementToHtml mParentNs ele =
  ctor
    (HH.ElemName ele.name)
    (Array.fromFoldable $ map htmlAttributeToProp ele.attributes)
    children
  where
    mCurNs = Array.find (\(HtmlAttribute k _) -> k == "xmlns") ele.attributes <#>
      \(HtmlAttribute _ v) -> HH.Namespace v
    mNs = mCurNs <|> mParentNs
    children = ele.children <#> nodeToHtml mNs
    ctor = case mNs of
      Just ns -> HH.elementNS ns
      Nothing -> HH.element

nodeToHtml :: forall p i. Maybe HH.Namespace -> HtmlNode -> HH.HTML p i
nodeToHtml mNs (HtmlElement ele) = elementToHtml mNs ele
nodeToHtml _ (HtmlText str) = HH.text str
nodeToHtml _ (HtmlComment _) = HH.text ""

render_ :: forall p i. String -> HH.HTML p i
render_ = render []

render :: forall p i. Array (HH.IProp HTMLdiv i) -> String -> HH.HTML p i
render props = HH.div props <<< renderToArray

renderToArray :: forall p i. String -> Array (HH.HTML p i)
renderToArray raw = map (nodeToHtml Nothing) $ parse raw
