module Main where

import Prelude
import Data.Maybe (Maybe(..))
import Effect (Effect)
import Effect.Console (log)
import Web.DOM as DOM
import Web.DOM.Document as Doc
import Web.DOM.Element as Element
import Web.DOM.Node as Node
import Web.DOM.Text as Text
import Web.HTML (window)
import Web.HTML.HTMLDocument (body, toDocument)
import Web.HTML.HTMLElement as HElement
import Web.HTML.Window (document)

main :: Effect Unit
main = do
  p <- createParagraph "Purescript Web App Starter works!"
  withBodyNode \bodyNode ->
    Node.appendChild (Element.toNode p) bodyNode

withBodyNode :: (DOM.Node -> Effect Unit) -> Effect Unit
withBodyNode callback =
  findBodyNode
    >>= case _ of
        Nothing -> log "Couldn't find Document.body"
        Just bodyNode -> callback bodyNode
  where
  findBodyNode :: Effect (Maybe DOM.Node)
  findBodyNode = 
    window >>= document >>= body
      <#> map (HElement.toElement >>> Element.toNode)

createParagraph :: String -> Effect DOM.Element
createParagraph content = do
  doc <- window >>= document <#> toDocument
  node <- Doc.createElement "p" doc
  text <- Doc.createTextNode content doc
  Node.appendChild (Text.toNode text) (Element.toNode node)
  pure node
