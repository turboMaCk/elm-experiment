module Gen1.App exposing (..)

import Gen1.Action as Action exposing (Action)
import Gen1.View exposing (View)
import Html exposing (Html)


type alias App a =
    Program Never a (Action a)


start : View a -> a -> App a
start view state =
    Html.beginnerProgram
        { model = state
        , view = view
        , update = Action.update
        }
