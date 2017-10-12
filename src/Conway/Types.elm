module Conway.Types exposing (..)
import Time exposing (Time)
import Array exposing (Array)

type Msg = Tick Time
type alias Grid a = Array (Array a)

type alias Model =
  { count: Int
  , grid: Grid Bool
  }

model : Model
model = Model 0 <| Array.initialize 0 <| always (Array.initialize 0 (always True))
