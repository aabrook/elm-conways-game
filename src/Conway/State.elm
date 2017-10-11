module Conway.State exposing (init, subscriptions, update)

import Conway.Types exposing (..)

import Time exposing (Time, second)

init : (Model, Cmd Msg)
init = (model, Cmd.none)

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Tick time -> ({ model | count = model.count + 1 }, Cmd.none)

subscriptions : Model -> Sub Msg
subscriptions model =
  Time.every second Tick