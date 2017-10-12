module Conway.State exposing (init, subscriptions, update)

import Conway.Types exposing (..)
import Conway.Helper exposing (prepareGrid, tickState)

import Array
import Time exposing (Time, second)
import Random exposing (generate, Generator)

init : (Int -> Int -> Generator Bool) -> Int -> Int -> (Model, Cmd Msg)
init gen height width = ({
  model
  | height = height
  , width = width
  , generator = gen height width
  }, generate Gen <| gen height width)

initGrid rows cols state =
  let
    rowGenerator = Random.int 0 (rows-1)
    colGenerator = Random.int 0 (cols-1)
    locationGenerator = Random.pair rowGenerator colGenerator
    (c, s) = Random.step locationGenerator (Random.initialSeed 9)
  in
    model

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
  Time.every second Tick
