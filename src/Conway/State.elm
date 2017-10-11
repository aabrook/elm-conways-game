module Conway.State exposing (init, subscriptions, update)

import Conway.Types exposing (..)

import Time exposing (Time, second)

init : Int -> Int -> (Model, Cmd Msg)
init height width = ({ model | grid = prepareGrid height width }, Cmd.none)

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Tick time -> ({ model | count = model.count + 1 }, Cmd.none)

subscriptions : Model -> Sub Msg
subscriptions model =
  Time.every second Tick

prepareGrid : Int -> Int -> List (List Bool)
prepareGrid height width =
  List.repeat height (List.repeat width True)