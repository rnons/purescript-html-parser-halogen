module Test.Main where

import Prelude
import Control.Monad.Free (Free)
import Data.Array (length) as A
import Data.Maybe (Maybe(..))
import Data.Either (Either(..))
import Data.Bifunctor (rmap)
import Data.Tuple (Tuple(..))
import Effect (Effect)
import Test.Unit (Test, TestF, suite, test, failure, success)
import Test.Unit.Assert as Assert
import Test.Unit.Main (runTest)
import Html.Parser (parse)

assertParses :: String -> Test
assertParses s =
  case parse s of
    Right res ->
      success

    Left err ->
      failure ("parse failed: " <> (show err))

main :: Effect Unit
main = runTest do
  parserSuite

parserSuite :: Free TestF Unit
parserSuite =
  suite "parser" do
    test "simple iframe" do
      assertParses "<iframe></iframe>"
    test "iframe with valueless attribute" do
      assertParses "<iframe width ></iframe>"
    test "iframe with attribute" do
      assertParses """<iframe width ="560" ></iframe>"""
    test "iframe with singly-quoted attribute" do
      assertParses "<iframe width='560' ></iframe>"
    test "iframe with spaced attribute" do
      assertParses """<iframe width = "560" ></iframe>"""
    test "embedded youTube" do
      assertParses "<iframe width='560' height='315' src='//www.youtube.com/embed/gE6j-Zp323w' frameborder='0' allowfullscreen></iframe>"
