import Browser
import Html exposing (Html,button,div,text)
import Html.Events exposing (onClick)

main =
    Browser.sandbox
        { init = init
        , view = view
        , update = update
        }

-- Model

type alias Model = Int

init : Model
init = 0

-- update

type Msg
    = Increment
    | Decrement
    | Reset

update : Msg -> Model -> Model
update msg model =
    case msg of
        Increment ->
          model + 1

        Decrement ->
          model - 1

        Reset ->
          0

-- view

view : Model -> Html Msg
view model =
  div[]
  [
  button[onClick Decrement][text "-"]
  ,div [] [text(String.fromInt model)]
  ,button[onClick Increment ][text "+"]
  ,button[onClick Reset ][text "reset"]
  ]
