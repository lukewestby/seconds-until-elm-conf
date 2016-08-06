port module Stylesheets exposing (..)

import Css exposing (..)
import Css.File exposing (..)
import Html
import Html.App as Html


port files : CssFileStructure -> Cmd msg


css : Stylesheet
css =
    stylesheet
        <| List.concat []


cssFiles : CssFileStructure
cssFiles =
    toFileStructure [ ( "main.css", Css.File.compile css ) ]


main : Program Never
main =
    Html.program
        { init = ( (), files cssFiles )
        , view = \_ -> (Html.text "")
        , update = \_ _ -> ( (), Cmd.none )
        , subscriptions = \_ -> Sub.none
        }
