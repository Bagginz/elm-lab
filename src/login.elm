module Main exposing (..)
import Browser
import Html exposing(..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput, onClick)

main = 
    Browser.sandbox { init = init, update = update, view = view}

type alias Model = 
    {
        username : String,
        password : String
    }

init : Model 
init = 
    Model "" ""

type Msg
    = Username String
    | Password String

update : Msg -> Model -> Model 
update msg model =
    case msg of
        Username username ->
            { model | username = username }

        Password password ->
            { model | password = password}
            

view : Model -> Html Msg
view model = 
    div [class "form-signin", style "margin-top" "10%"] [
        img [src "./images/elmicon.png" ,width 72, height 72, style "text-align" "center"] [],
        div [ class "header-text-signin" ] [text "Please singn in"],
        div [] [viewInput "form-control" "text" "Username" model.username Username],
        div [] [viewInput "form-control" "password" "Password" model.password Password],
        div [] [button [class "btn btn-lg btn-primary btn-block", style "margin-top" "15px"] [text "Sign in"]],
        div [] [text (model.username)],
        div [] [text (model.password)]
    ]
    
viewInput : String -> String -> String -> String -> (String -> msg) -> Html msg
viewInput c t p v toMsg =
    input [class c, type_ t, placeholder p, value v, onInput toMsg] []
