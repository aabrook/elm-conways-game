module Conway.Helper exposing (..)

import Conway.Types exposing (..)
import Array exposing (Array, fromList, get)

prepareGrid : (Int -> Int -> Bool) -> Int -> Int -> Array (Array Bool)
prepareGrid gen height width =
  Array.initialize height (\x -> Array.initialize width (gen x))

tickState : Grid Bool -> Grid Bool
tickState grd =
  grd |> neighbourCount |> Array.map (Array.map isAlive)

neighbourCount : Grid Bool -> Grid (Bool, Int)
neighbourCount grd =
  let
    isDeadCell c =
      case c of
        Nothing -> 0
        Just n -> if n then 1 else 0

    getNeighbour x y =
      (get y grd) |> Maybe.andThen (\row -> get x row)

    n x y = getNeighbour x (y - 1)
    ne x y = getNeighbour (x + 1) (y - 1)
    e x y = getNeighbour (x + 1) y
    se x y = getNeighbour (x + 1) (y + 1)
    s x y = getNeighbour x (y + 1)
    sw x y = getNeighbour (x - 1) (y + 1)
    w x y = getNeighbour (x - 1) y
    nw x y = getNeighbour (x - 1) (y - 1)
    neighbours x y =
      Array.foldl (+) 0 (Array.map (\d -> isDeadCell <| d x y) <| fromList [n, ne, e, se, s, sw, w, nw])
  in
    Array.indexedMap (\y row -> Array.indexedMap (\x c -> (c, neighbours x y)) row) grd

isAlive: (Bool, Int) -> Bool
isAlive (alive, neighbours) =
  case neighbours of
    0 -> False
    1 -> False
    2 -> alive
    3 -> True
    _ -> False