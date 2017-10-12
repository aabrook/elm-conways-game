module Conway.View exposing (view)

import Html exposing (Html, table, td, tr, text, div, img)
import Html.Attributes exposing (style)
import Array exposing (Array)

import Conway.Types exposing (..)

view : Model -> Html Msg
view { count, grid, state } = div [] [
    renderState state
    , renderGrid grid
  ]

renderState : GenState -> Html Msg
renderState state =
  case state of
    Generating -> text "Generating"
    Generated -> text "Running"

renderGrid : Grid Bool -> Html Msg
renderGrid grid =
  table [tableStyle] (Array.toList <| Array.map renderRow grid)

renderRow : Array Bool -> Html Msg
renderRow row =
  let
    which n =
      case n of
        True -> td [] [text "."]
        False -> td [] [text " "]
  in
    Array.map (which) row
    |> Array.toList
    |> tr []

tableStyle : Html.Attribute msg
tableStyle = style [ ("border", "1px solid black"), ("width", "100%") ]