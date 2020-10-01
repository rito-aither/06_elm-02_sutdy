module Sample4 exposing (..)
import Browser exposing (..)
import Html exposing (Html,text,pre)
import Http


-- main

main =
  Browser.element
    { init = init
    , update = update
    , subscriptions = subscriptions
    , view = view
    }

-- model


type Model
    = Failure
    | Loading
    | Success String


init :() -> (Model,Cmd Msg)
init _ =
  (Loading
  ,Http.get
    {url = "https://elm-lang.org/assets/public-opinion.txt"
    , expect = Http.expectString Gottext
     }

  )


type Msg
  = Gottext(Result Http.Error String)


-- update

update : Msg -> Model ->  ( Model, Cmd Msg )
update msg model =
    case msg of
      Gottext result ->
          case result of
            Ok  fullText ->
              ( Success fullText, Cmd.none)

            Err _  ->
              ( Failure, Cmd.none )

--subscriptions

subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


-- view

view : Model -> Html Msg
view model =
    case model of
      Failure ->
        text "I was unable to load your book."

      Loading ->
        text  "Loading..."

      Success fullText ->
        pre[] [text fullText]
