module Conway.State exposing (init, subscriptions, update)

import Conway.Types exposing (..)
import Conway.Helper exposing (prepareGrid, tickState)

import Array
import Time exposing (Time, millisecond)
import Random exposing (generate, Generator)

init : Generator Bool -> Int -> Int -> Int -> (Model, Cmd Msg)
init gen height width scale = ({
  model
  | height = height
  , width = width
  , scale = scale
  , generator = gen
  }, generate Gen gen)

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Tick time -> (
      { model
      | grid = tickState model.grid
      }
      , Cmd.none
    )
    Gen b ->
      let
        store = b :: model.store
        size = model.height * model.width
        continue = List.length store < size
        state = case model.state of
          Generated -> Generated
          Generating -> if continue then Generating else Generated
        next =
          if continue then
            generate Gen model.generator
          else
            Cmd.none
        grid =
          if continue then
            model.grid
          else
            updateGrid model.store model.height model.width
      in
      (
        { model
        | store = store
        , grid = grid
        , state = state
        }
        , next
      )

updateGrid : List Bool -> Int -> Int -> Grid Bool
updateGrid seeds height width =
  let
    which x y =
      case Array.get (height * y + x) <| Array.fromList seeds of
        Nothing -> False
        Just b -> b
  in
    prepareGrid which height width


subscriptions : Model -> Sub Msg
subscriptions model =
  Time.every (250 * millisecond) Tick
