module Conway.View exposing (view)
import Html exposing (Html, text, div, img)

import Conway.Types exposing (Model, Msg)

view : Model -> Html Msg
view { count } = div [] [
    text <| toString count
  ]