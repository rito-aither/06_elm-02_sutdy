import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)

--main

main : Program () Model Msg
main =
    Browser.sandbox
        { init = init
        , view = view
        , update = update
        }

type alias Model =
    { name : String
    , password : String
    , passwordAgain : String
    }

init : Model
init =
  Model "" "" ""

--update

type Msg
    = Name String
    | Password String
    | PasswordAgain String

update : Msg -> Model -> Model
update msg model =
    case msg of
        Name name ->
          {model | name = name }

        Password password ->
          {model | password = password}

        PasswordAgain password ->
          {model | passwordAgain = password}

-- view

view : Model -> Html Msg
view model =
    div[]
      [
        viewInput "text" " Name" model.name Name
        ,viewInput "password" "Password" model.password Password
        ,viewInput "password" "Re-enter Password" model.passwordAgain PasswordAgain
        ,viweValidation model
      ]

viewInput : String -> String -> String -> (String -> msg) -> Html msg
viewInput t p v toMsg =
    input [type_ t , placeholder p, value v,onInput toMsg]  []

viweValidation : Model -> Html Msg
viweValidation model =
  if model.password == model.passwordAgain then
    div [style "color" "green"] [text "ok"]
  else
    div [style "color" "red"] [text "Passwords do not match"]
