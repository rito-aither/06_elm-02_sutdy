module Sample5 exposing (..)

import Browser exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Http exposing (..)
import Json.Decode exposing (Decoder, field, string)


--main

main : Program () Model Msg
main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


-- model

type Model
    = Failure
    | Loading
    | Success String

init : () -> (Model,Cmd Msg)
init _ =
  (Loading,getRandomCatGif)

-- update

type Msg
    = MorePlease
    | GotGif (Result Http.Error String)


update : Msg -> Model ->  ( Model, Cmd Msg )
update msg model =
    case msg of
        MorePlease ->
             ( Loading,getRandomCatGif)

        GotGif result ->
          case result of
            Ok url ->
             ( Success url, Cmd.none )


            Err _ ->
              (Failure , Cmd.none)


-- subscriptios

subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


-- view

view : Model -> Html Msg
view model =
   div []
    [ h2 [] [ text "Random Cats" ]
    , viewGif model
    ]

viewGif : Model -> Html Msg
viewGif model =
  case model of
    Failure ->
      div []
        [text "I could not load a randow cat for some reason."
        , button[onClick MorePlease][text "try again"]
        ]
    Loading ->
      text "loading"

    Success url ->
      div[]
        [button [onClick MorePlease , style "display" "block"][text "More please"]
        , img [ src url ] []
        ]

-- HTTP

getRandomCatGif :Cmd Msg
getRandomCatGif =
  Http.get {
    url = "https://api.giphy.com/v1/gifs/random?api_key=dc6zaTOxFJmzC&tag=cat"
  , expect = Http.expectJson GotGif gifDecoder
  }

gifDecoder : Decoder String
gifDecoder =
  field "data" (field "image_url" string)
