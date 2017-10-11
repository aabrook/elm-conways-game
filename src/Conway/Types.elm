module Conway.Types exposing (..)
import Time exposing (Time)

type Msg = Tick Time

type alias Model =
  { count: Int
  , grid: List (List Bool)
  }

model : Model
model = Model 0 []
