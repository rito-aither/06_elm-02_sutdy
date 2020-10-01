module Sample6 exposing (..)

import Browser
import Html exposing (..)
import Html.Events exposing (..)
import Random



--main


main : Program () Model Msg
main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }



--model


type alias Model =
    { dieFace : Int
    }


init : () -> ( Model, Cmd Msg )
init _ =
    ( Model 1
    , Cmd.none
    )



--update


type Msg
    = Roll
    | NewFace Int


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Roll ->
            ( model
            , Random.generate NewFace (Random.int 1 6)
            )

        NewFace nweFace ->
            ( Model nweFace
            , Cmd.none
            )


-- subscriptions

subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


-- viwe

view : Model -> Html Msg
view model =
    div[]
      [h1[][text (String.fromInt model.dieFace)]
      , button [onClick Roll ] [text "Roll"]
      ]
