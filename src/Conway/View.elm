module Conway.View exposing (view)

import Html exposing (Html, table, td, tr, text, div, img)

import Svg exposing (Svg, svg, rect, text)
import Svg.Attributes exposing (fill, height, viewBox, width, scale, x, y, rx, ry)

import Array exposing (Array)

import Conway.Types exposing (..)

view : Model -> Html Msg
view { height, scale, count, grid, state } = div [] [
    renderState state
    , Html.br [] []
    , renderGrid height scale grid
  ]

renderState : GenState -> Html Msg
renderState state =
  case state of
    Generating -> Html.text "Generating"
    Generated -> Html.text "Running"

renderGrid : Int -> Int -> Grid Bool -> Html Msg
renderGrid dimension scale grid =
  svg (svgStyle dimension scale) (Array.toList <| Array.indexedMap (renderRow dimension scale) grid)

renderRow : Int -> Int -> Int -> Array Bool -> Svg Msg
renderRow dimension scale yPos row =
  let
    yp = toString <| scale * yPos
    d = dimension * scale
    dx = (toFloat d) / (toFloat <| Array.length row) |> toString
    which xPos n =
      case n of
        True -> rect [height dx, width dx, x <| toString <| scale * xPos, y yp, fill "#000"] []
        False -> rect [height dx, width dx, x <| toString <| scale * xPos, y yp, fill "#FFF"] []
  in
    Array.indexedMap which row
    |> Array.toList
    |> svg []

svgStyle : Int -> Int -> List (Svg.Attribute a)
svgStyle h scale =
  let
    dx = toString <| h * scale
  in
    [height dx, width dx, viewBox dx]