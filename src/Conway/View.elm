module Conway.View exposing (view)

import Html exposing (Html, table, td, tr, text, div, img)
import Html.Attributes exposing (style)

import Conway.Types exposing (Grid, Model, Msg)

view : Model -> Html Msg
view { count, grid } = div [] [
    text <| toString count
    , renderGrid grid
  ]

renderGrid : Grid Bool -> Html Msg
renderGrid grid =
  let
    which n =
      case n of
        True -> td [] [text "."]
        False -> td [] [text " "]
  in
    table [tableStyle] <| List.map (\row -> tr [] <| List.map which row) grid

tableStyle : Html.Attribute msg
tableStyle = style [ ("border", "1px solid black"), ("width", "100%") ]