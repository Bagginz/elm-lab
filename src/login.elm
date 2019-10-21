module Main exposing (..)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onInput)
import Http exposing (..)
import Json.Decode exposing (Decoder, Error, at, bool, field, int, list, map, nullable, string, succeed)
import Json.Decode.Pipeline exposing (optional, required)
import Json.Encode as Encode


main =
    Browser.element { init = init, update = update, view = view, subscriptions = subscriptions }


type alias Model =
    { username : String
    , password : String
    , login : Bool
    , errorMessage : String
    }


initialModel : Model
initialModel =
    { username = "", password = "", login = False, errorMessage = "" }


init : String -> ( Model, Cmd Msg )
init flags =
    ( initialModel, Cmd.none )


type Msg
    = Username String
    | Password String
    | Login
    | LoginResponse (Result Http.Error Model)


jsonResponseDecoder : Decoder Model
jsonResponseDecoder =
    succeed Model
        |> required "username" string
        |> required "password" string
        |> required "login" bool
        |> required "errorMessage" string


jsonRequestEncoder : Model -> Encode.Value
jsonRequestEncoder model =
    Encode.object
        [ ( "username", Encode.string model.username )
        , ( "password", Encode.string model.password )
        ]


errorToString : Http.Error -> String
errorToString error =
    case error of
        BadUrl url ->
            "The URL " ++ url ++ " was invalid"

        Timeout ->
            "Unable to reach the server, try again"

        NetworkError ->
            "Unable to reach the server, check your network connection"

        BadStatus 500 ->
            "The server had a problem, try again later"

        BadStatus 400 ->
            "Verify your information and try again"

        BadStatus _ ->
            "Unknown error"

        BadBody errorMessage ->
            errorMessage


submitCmd : Model -> Cmd Msg
submitCmd model =
    Http.post
        { url = "http://localhost:3000/login/checklogin"
        , body = Http.jsonBody <| jsonRequestEncoder model
        , expect = Http.expectJson LoginResponse jsonResponseDecoder
        }


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Username username ->
            let
                currentModel =
                    { model | username = username }
            in
            ( currentModel, Cmd.none )

        Password password ->
            let
                currentModel =
                    { model | password = password }
            in
            ( currentModel, Cmd.none )

        Login ->
            ( model, submitCmd model )

        LoginResponse (Ok response) ->
            let
                loginResponse =
                    if response.login then
                        { model | errorMessage = "SUCCESS" }

                    else
                        { model | errorMessage = "FAILED" }
            in
            ( loginResponse, Cmd.none )

        LoginResponse (Err httpError) ->
            ( { model | errorMessage = errorToString httpError }, Cmd.none )


view : Model -> Html Msg
view model =
    div [ class "form-signin", style "margin-top" "10%" ]
        [ img [ src "./images/elmicon.png", width 72, height 72, style "text-align" "center" ] []
        , div [ class "header-text-signin" ] [ text "Please singn in" ]
        , div [] [ viewInput "form-control" "text" "Username" model.username Username ]
        , div [] [ viewInput "form-control" "password" "Password" model.password Password ]
        , div [] [ button [ class "btn btn-lg btn-primary btn-block", style "margin-top" "15px", onClick Login ] [ text "Sign in" ] ]
        , div [] [ text model.username ]
        , div [] [ text model.password ]

        -- , div [] [ text model.login ]
        , div [] [ text model.errorMessage ]
        ]


viewInput : String -> String -> String -> String -> (String -> msg) -> Html msg
viewInput c t p v toMsg =
    input [ class c, type_ t, placeholder p, value v, onInput toMsg ] []
