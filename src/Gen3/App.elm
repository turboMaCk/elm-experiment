module Gen3.App exposing (..)

import Gen3.Action as Action exposing (Action)
import Gen3.View exposing (View)
import Html exposing (Html)


type alias App a =
    Program Never a (Action a)


start : View a a -> ( a, Cmd (Action a) ) -> App a
start view init =
    Html.program
        { init = init
        , view = view
        , update = Action.update
        , subscriptions = \_ -> Sub.none
        }
