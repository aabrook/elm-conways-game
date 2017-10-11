module Main exposing (..)

import Html exposing (Html, text, div, img)
import Html.Attributes exposing (src)

import Conway.Types as CT exposing (Model, model)
import Conway.View as CV exposing (view)
import Conway.State as CS exposing (init, update)

---- MODEL ----

type alias Model ={
    conway: CT.Model
  }

init : ( Model, Cmd Msg )
init =
  let
    (cmodel, cmsg) = CS.init (always <| always True) 10 10
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
    [ img [ src "/logo.svg" ] []
    , div [] [ text "Your Elm App is working!" ]
    , Html.map Conway <| CV.view conway
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
