module Conway.State exposing (init, subscriptions, update)

import Conway.Types exposing (..)

import Time exposing (Time, second)

init : (Int -> Int -> Bool) -> Int -> Int -> (Model, Cmd Msg)
init gen height width = ({ model | grid = prepareGrid gen height width }, Cmd.none)

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Tick time -> ({ model | count = model.count + 1 }, Cmd.none)

subscriptions : Model -> Sub Msg
subscriptions model =
  Time.every second Tick

prepareGrid : (Int -> Int -> Bool) -> Int -> Int -> List (List Bool)
prepareGrid gen height width =
  List.map (\x -> (List.map (\y -> gen x y) <| List.range 0 width)) (List.range 0 height)
