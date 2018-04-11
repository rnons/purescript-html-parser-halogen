module App where

import Prelude

import Data.Maybe (Maybe(..))

import Halogen as H
import Halogen.HTML as HH
import Halogen.HTML.Events as HE
import Halogen.HTML.Properties as HP
import Html.Parser.Halogen as PH

data Query a = OnValueChange String a

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
  </div>
</div>
"""

initialState :: State
initialState = { value: initValue }

class_ :: forall r i. String -> HP.IProp ("class" :: String | r) i
class_ = HP.class_ <<< HH.ClassName

render :: State -> H.ComponentHTML Query
render state =
  HH.div [ class_ "grid" ]
  [ HH.h2 [ class_ "header" ]
    [ HH.text "purescript-html-parser-halogen example" ]
  , HH.div [ class_ "col col-edit" ]
    [ HH.h4_ [ HH.text "EDIT" ]
    , HH.textarea
      [ class_ "edit"
      , HP.value state.value
      , HE.onValueInput $ HE.input OnValueChange
      ]
    ]
  , HH.div [ class_ "col col-preview" ]
    [ HH.h4_ [ HH.text "PREVIEW" ]
    , HH.div [ class_ "preview" ]
      [ PH.render state.value ]
    ]
  , HH.div [ class_ "footer" ]
    [ HH.a
      [ HP.href demoSourceUrl] [HH.text "source code"]
    ]
  ]
  where
  repoUrl = "https://github.com/rnons/purescript-html-parser-halogen"
  demoSourceUrl = repoUrl <> "/tree/master/example"

app :: forall m. H.Component HH.HTML Query Unit Void m
app =
  H.component
    { initialState: const initialState
    , render
    , eval
    , receiver: const Nothing
    }
  where
  eval :: Query ~> H.ComponentDSL State Query Void m
  eval = case _ of
    OnValueChange value next -> do
      H.modify $ _ { value = value }
      pure next
