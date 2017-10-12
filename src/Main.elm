module Main exposing (..)

import Html exposing (Html, text, div, img)

import Random exposing (bool, Generator)
import Conway.Types as CT exposing (Model, model)
import Conway.View as CV exposing (view)
import Conway.State as CS exposing (init, update)

---- MODEL ----

type alias Model ={
    conway: CT.Model
  }

isEven : Int -> Bool
isEven n = n % 2 == 0

gridGenerator : Int -> Int -> Generator Bool
gridGenerator height width = bool -- (isEven height) == (isEven width)

init : ( Model, Cmd Msg )
init =
  let
    (cmodel, cmsg) = CS.init gridGenerator 50 50
  in
    ( Model cmodel, Cmd.batch [Cmd.map Conway cmsg] )

---- UPDATE ----

type Msg
  = NoOp
  | Conway CT.Msg

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
  case msg of
    Conway m ->
      let
          (cmodel, cmsg) = CS.update m model.conway
      in
        ({ model | conway = cmodel }, Cmd.map Conway cmsg)
    NoOp -> (model, Cmd.none)

---- VIEW ----

view : Model -> Html Msg
view { conway } =
  div []
    [ Html.map Conway <| CV.view conway
    ]

subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.batch [Sub.map Conway <| CS.subscriptions model.conway]

---- PROGRAM ----

main : Program Never Model Msg
main =
  Html.program
    { view = view
    , init = init
    , update = update
    , subscriptions = subscriptions
    }
