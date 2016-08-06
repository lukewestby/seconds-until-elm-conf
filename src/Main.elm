module Main exposing (..)

import Date
import Time exposing (Time)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.App as Html
import Html.CssHelpers


elmConfStartTime : Time
elmConfStartTime =
    Date.fromString "2016-09-15T09:00:00-05:00"
        |> Result.map Date.toTime
        |> Result.withDefault 0


elmConfEndTime : Time
elmConfEndTime =
    Date.fromString "2016-09-15T17:00:00-05:00"
        |> Result.map Date.toTime
        |> Result.withDefault 0


type alias Model =
    Time


type Msg
    = Tick Time


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Tick time ->
            ( time
            , Cmd.none
            )


subscriptions : Model -> Sub Msg
subscriptions model =
    if model < elmConfStartTime then
        Time.every Time.second Tick
    else
        Sub.none


init : { now : Time } -> ( Model, Cmd Msg )
init { now } =
    ( now
    , Cmd.none
    )


view : Model -> Html Msg
view model =
    if model >= elmConfStartTime && model <= elmConfEndTime then
        div [] [ text "ELM CONF IS NOW" ]
    else if model > elmConfEndTime then
        div [] [ text "Elm Conf already happened :( See you next year!" ]
    else
        div []
            [ text <| (toString (round ((elmConfStartTime - model) / Time.second))) ++ " seconds till "
            , a [ href "http://elm-conf.us" ] [ text "Elm Conf" ]
            , text "!"
            ]


main : Program { now : Time }
main =
    Html.programWithFlags
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view
        }
