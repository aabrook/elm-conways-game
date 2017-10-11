module Conway.View exposing (view)
import Html exposing (Html, table, tr, text, div, img)

import Conway.Types exposing (Model, Msg)

view : Model -> Html Msg
view { count, grid } = div [] [
    text <| toString count
    , renderGrid grid
  ]

renderGrid : List (List Bool) -> Html Msg
renderGrid grid =
  table [] <| List.map (\row -> tr [] <| List.map (toString >> text) row) grid