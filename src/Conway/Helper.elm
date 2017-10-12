module Conway.Helper exposing (..)

import Conway.Types exposing (..)
import Array exposing (fromList, get)

prepareGrid : (Int -> Int -> Bool) -> Int -> Int -> List (List Bool)
prepareGrid gen height width =
  List.map (\x -> (List.map (\y -> gen x y) <| List.range 0 width)) (List.range 0 height)

tickState : Grid Bool -> Grid Bool
tickState grd =
  grd |> neighbourCount |> List.map (List.map isDead)

neighbourCount : Grid Bool -> Grid (Bool, Int)
neighbourCount grd =
  let
    isDeadCell c =
      case c of
        Nothing -> 0
        Just n -> if n then 1 else 0

    getNeighbour x y =
      (get (y - 1) (fromList grd)) |> Maybe.andThen (\row -> get x <| fromList row)

    n x y = getNeighbour x (y - 1)
    ne x y = getNeighbour (x + 1) (y - 1)
    e x y = getNeighbour (x + 1) y
    se x y = getNeighbour (x + 1) (y + 1)
    s x y = getNeighbour x (y + 1)
    sw x y = getNeighbour (x - 1) (y + 1)
    w x y = getNeighbour (x - 1) y
    nw x y = getNeighbour (x - 1) (y - 1)
    neighbours x y =
      List.sum (List.map (\d -> isDeadCell <| d x y) [n, ne, e, se, s, sw, w, nw])
  in
    List.indexedMap (\y row -> List.indexedMap (\x c -> (c, neighbours x y)) row) grd

isDead : (Bool, Int) -> Bool
isDead (dead, neighbours) =
  case neighbours of
    0 -> False
    1 -> False
    2 -> dead
    3 -> True
    _ -> False