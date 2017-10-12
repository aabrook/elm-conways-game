module Conway.State exposing (init, subscriptions, update)

import Conway.Types exposing (..)
import Conway.Helper exposing (prepareGrid, tickState)

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
