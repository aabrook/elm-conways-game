module Conway.Types exposing (..)
import Time exposing (Time)
import Array exposing (Array)
import Random exposing (bool, Generator)

type GenState = Generating | Generated
type Msg = Tick Time
  | Gen Bool
type alias Grid a = Array (Array a)

type alias Model =
  { count: Int
  , height: Int
  , width: Int
  , scale: Int
  , grid: Grid Bool
  , state: GenState
  , store: List Bool
  , generator: Generator Bool
  }

model : Model
model =
  Model
  0
  0
  0
  0
  (Array.initialize 0 <| always <| Array.initialize 0 <| always True)
  Generating
  []
  bool
