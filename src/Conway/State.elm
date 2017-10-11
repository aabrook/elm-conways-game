module Conway.State exposing (init, subscriptions, update)

import Conway.Types exposing (..)

import Time exposing (Time, second)

init : (Int -> Int -> Bool) -> Int -> Int -> (Model, Cmd Msg)
init gen height width = ({ model | grid = prepareGrid gen height width }, Cmd.none)

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Tick time -> (
      { model
      | count = model.count + 1
      , grid = tickState model.grid
      }
      , Cmd.none
    )

subscriptions : Model -> Sub Msg
subscriptions model =
  Time.every second Tick

prepareGrid : (Int -> Int -> Bool) -> Int -> Int -> List (List Bool)
prepareGrid gen height width =
  List.map (\x -> (List.map (\y -> gen x y) <| List.range 0 width)) (List.range 0 height)

tickState : Grid Bool -> Grid Bool
tickState = List.map (\row -> List.map (\b -> isDead b 2) row)

isDead : Bool -> Int -> Bool
isDead dead neighbours = not dead
{-
  case neighbours of
    0 -> False
    1 -> False
    2 -> dead
    3 -> True
    _ -> False
-}