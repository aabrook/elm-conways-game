module Tests exposing (..)

import Test exposing (..)
import Expect

import Conway.Helper exposing (..)
import Array exposing (fromList)


-- Check out http://package.elm-lang.org/packages/elm-community/elm-test/latest to learn more about testing in Elm!


all : Test
all =
  describe "A Test Suite"
    [ test "The grid calculates correctly" <|
      \_ ->
        let
          a =
            [ [True, True, True]
            , [True, True, True]
            , [True, True, True]
            ]
            |> Array.fromList
            |> Array.map Array.fromList
          b =
            [ [True, False, True]
            , [False, False, False]
            , [True, False, True]
            ]
            |> Array.fromList
            |> Array.map Array.fromList
        in
          Expect.equal (tickState a) b
    ]
