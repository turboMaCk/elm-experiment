module Gen4.App exposing (..)

import Gen4.Action as Action exposing (Action)
import Gen4.View as View exposing (View)
import Html


type alias App a =
    Program Never a (Action a a)


start : View a a -> a -> App a
start view model =
    Html.beginnerProgram
        { model = model
        , view = view
        , update = Action.update
        }
