module Page.Home exposing (Model, Msg, init, subscriptions, update, view)

import Browser.Dom as Dom
import Html exposing (..)
import Html.Attributes exposing (attribute, class, classList, href, id, placeholder)
import Html.Events exposing (onClick)
import Http exposing (..)
import Page



-- MODEL


type alias Model =
    { title : String
    , content : String
    }


innitialModel : Model
innitialModel =
    { title = "Hello", content = "Hello World!!" }


init : String -> ( Model, Cmd Msg )
init session =
    ( innitialModel, Cmd.none )



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ div [ onClick Clicked ] [ text model.content ]
        ]



-- UPDATE


type Msg
    = Clicked


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Clicked ->
            let
                currentModel =
                    { model | content = "iiiiii" }
            in
            ( currentModel, Cmd.none )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
