import Browser
import Html exposing (Html,Attribute,div,input,text)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)


-- main

main =
    Browser.sandbox
        { init = init
        , view = view
        , update = update
        }


-- model

type alias Model =
    { content : String
    }

init : Model
init =
  {content = "" }

-- update

type Msg
    = Change String

update : Msg -> Model-> Model
update msg model =
  case msg of
    Change newContent ->
      { model | content = String.reverse newContent }

-- view
view : Model -> Html Msg
view model =
    div[]
      [
        input [placeholder "Text to reverse" , value model.content ,onInput Change][]
        ,div[][text (model.content)]
      ]
