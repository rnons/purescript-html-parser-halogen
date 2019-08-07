module App where

import Prelude

import Data.Const (Const)
import Data.Maybe (Maybe(..))
import Halogen as H
import Halogen.HTML as HH
import Halogen.HTML.Events as HE
import Halogen.HTML.Properties as HP
import Html.Renderer.Halogen as PH

type Query = Const Void

data Action = OnValueChange String

type State = { value:: String }


initValue :: String
initValue = """
<!--
A small library that renders raw HTML string into Halogen views.
Use it only when you trust the raw HTML string.
See README for more info.
-->

<div class="grid">
  <h2 class="header">purescript-html-parser-halogen example</h2>
  <div class="col col-edit">
    <h4>EDIT</h4>
    <textarea class="edit"></textarea>
  </div>
  <div class="col col-preview">
    <h4>PREVIEW</h4>
    <div class="preview"></div>
  </div>
  <div class="footer">
    <a href="https://github.com/rnons/purescript-html-parser-halogen/tree/master/example">source code</a>
    Powered by <img src="https://upload.wikimedia.org/wikipedia/commons/6/64/PureScript_Logo.png" style="width: 1rem; height: 1rem">
  </div>
</div>
"""

initialState :: State
initialState = { value: initValue }

class_ :: forall r i. String -> HP.IProp ("class" :: String | r) i
class_ = HP.class_ <<< HH.ClassName

style :: forall r i. String -> HP.IProp ("style" :: String | r) i
style = HP.attr (HH.AttrName "style")

render :: forall m. State -> H.ComponentHTML Action () m
render state =
  HH.div [ class_ "grid" ]
  [ HH.h2 [ class_ "header" ]
    [ HH.text "purescript-html-parser-halogen example" ]
  , HH.div [ class_ "col col-edit" ]
    [ HH.h4_ [ HH.text "EDIT" ]
    , HH.textarea
      [ class_ "edit"
      , HP.value state.value
      , HE.onValueInput $ Just <<< OnValueChange
      ]
    ]
  , HH.div [ class_ "col col-preview" ]
    [ HH.h4_ [ HH.text "PREVIEW" ]
    , HH.div [ class_ "preview" ]
      [ PH.render_ state.value ]
    ]
  , HH.div [ class_ "footer" ]
    [ HH.a
      [ HP.href demoSourceUrl] [HH.text "source code"]
    , HH.text " Powered by "
    , HH.img
      [ HP.src "https://upload.wikimedia.org/wikipedia/commons/6/64/PureScript_Logo.png"
      , style "width: 1rem; height: 1rem"
      ]
    ]
  ]
  where
  repoUrl = "https://github.com/rnons/purescript-html-parser-halogen"
  demoSourceUrl = repoUrl <> "/tree/master/example"

app :: forall m. H.Component HH.HTML Query Unit Void m
app = H.mkComponent
  { initialState: const initialState
  , render
  , eval: H.mkEval $ H.defaultEval
      { handleAction = handleAction }
  }

handleAction :: forall m. Action -> H.HalogenM State Action () Void m Unit
handleAction = case _ of
  OnValueChange value -> do
    H.modify_ $ _ { value = value }
