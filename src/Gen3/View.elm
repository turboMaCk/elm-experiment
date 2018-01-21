module Gen3.View exposing (..)

import Gen3.Action as Action exposing (Action)
import Html exposing (Html)


type alias View a b =
    a -> Html (Action b)


map : (a -> b) -> Html (Action a) -> Html (Action b)
map predicate =
    Html.map (Action.map predicate)
