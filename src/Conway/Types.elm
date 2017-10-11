module Conway.Types exposing (..)
import Time exposing (Time)

type Msg = Tick Time
type alias Grid a = List (List a)

type alias Model =
  { count: Int
  , grid: Grid Bool
  }

model : Model
model = Model 0 []
