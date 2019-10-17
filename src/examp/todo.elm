module Main exposing (TodoModel, main)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onInput)
import List exposing (..)


main =
    Browser.sandbox { init = init, update = update, view = view }


type alias TodoListModel =
    { listtodo : List TodoModel, currenttodo : String }


type alias TodoModel =
    { name : String
    , id : Int
    }


init : TodoListModel
init =
    { listtodo = []
    , currenttodo = ""
    }


type Msg
    = PushMsg
    | AddTodo String
    | RemoveList Int


update : Msg -> TodoListModel -> TodoListModel
update msg model =
    case msg of
        PushMsg ->
            let
                updatelistx =
                    updateList model
            in
            updatelistx

        AddTodo todo ->
            { model | currenttodo = todo }

        RemoveList id ->
            let
                removetodolist =
                    removeList id model
            in
            removetodolist


updateList : TodoListModel -> TodoListModel
updateList listmodel =
    let
        lengthTodo =
            List.length listmodel.listtodo

        todoTextList =
            [ { name = listmodel.currenttodo, id = lengthTodo } ]
    in
    { listmodel | listtodo = List.append todoTextList listmodel.listtodo }


removeList : Int -> TodoListModel -> TodoListModel
removeList id model =
    { model | listtodo = List.filter (\x -> x.id /= id) model.listtodo }


rowItem : TodoModel -> Html Msg
rowItem message =
    div []
        [ div [ style "float" "left", style "width" "200px" ] [ text message.name ]
        , div [ style "float" "left", style "width" "200px" ] [ text (String.fromInt message.id) ]
        , div [] [ button [ onClick (RemoveList message.id) ] [ text "ลบดิวะ" ] ]
        ]


view : TodoListModel -> Html Msg
view model =
    div [ class "form-signin", style "margin-top" "10%" ]
        [ div [] [ viewInput "form-control" "text" "TodoText" model.currenttodo AddTodo ]
        , div [] [ button [ class "btn btn-lg btn-primary btn-block", style "margin-top" "15px", onClick PushMsg ] [ text "PUSH" ] ]
        , div [] (List.map rowItem model.listtodo)
        ]


viewInput : String -> String -> String -> String -> (String -> msg) -> Html msg
viewInput c t p v toMsg =
    input [ class c, type_ t, placeholder p, value v, onInput toMsg ] []
