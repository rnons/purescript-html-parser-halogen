# purescript-html-parser-halogen

[![purescript-html-parser-halogen on Pursuit](https://pursuit.purescript.org/packages/purescript-html-parser-halogen/badge)](https://pursuit.purescript.org/packages/purescript-html-parser-halogen)

A library to render raw HTML string into Halogen views. You might also be interested in [purescript-markdown-it-halogen](https://github.com/nonbili/purescript-markdown-it-halogen), a library to render Markdown into Halogen views.

[Playground](https://rnons.github.io/purescript-html-parser-halogen/)

## How to use

```purescript
import Html.Renderer.Halogen as RH

rawHtml :: String
rawHtml = """<a href="https://github.com">a link</a>"""

render =
  ...
  HH.div_ [ RH.render_ rawHtml ]
```

It's as simple as this, in most cases you only need the `render` function from `Html.Renderer.Halogen` module.

## Be cautious

This library doesn't support malformed HTML, and is prone to XSS attack. Use it only when you trust the HTML string.

You can balance and sanitize the HTML on the backend, e.g. `sanitizeBalance` from [xss-sanitize](http://hackage.haskell.org/package/xss-sanitize/docs/Text-HTML-SanitizeXSS.html#v:sanitizeBalance).

## How it works

`Html.Parser` parses HTML `String` as `HtmlNode`. `Html.Renderer.Halogen` converts `HtmlNode` to halogen `HTML`. You can also write adapters to convert `HtmlNode` to the `HTML` type of other view libraries.

If you want to `Html.Parser` with other view libraries, I can release it as a separate package, let me know if you are interested.

## Other approaches to render raw HTML into halogen views

- https://github.com/slamdata/purescript-halogen/issues/324
