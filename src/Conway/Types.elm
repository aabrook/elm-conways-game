module Conway.Types exposing (..)
import Time exposing (Time)

type Msg = Tick Time

type alias Model = {
    count: Int
  }

model : Model
model = Model 0