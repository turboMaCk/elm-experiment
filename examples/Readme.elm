module Examples.Readme exposing (main)

import Gen1.Action as Action exposing (Action)
import Gen1.App as App exposing (App)
import Gen1.View as View exposing (View)
import Html exposing (Html)
import Html.Events as Events


main : App Int
main =
    App.start view 0


view : View Int
view state =
    Html.div []
        [ Html.button [ Events.onClick <| Action.action (flip (-) 1) state ] [ Html.text "-" ]
        , Html.text (Basics.toString state)
        , Html.button [ Events.onClick <| Action.action ((+) 1) state ] [ Html.text "+" ]
        ]
