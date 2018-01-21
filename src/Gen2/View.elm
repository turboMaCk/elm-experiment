module Gen2.View exposing (..)

import Gen2.Action as Action exposing (Action)
import Html exposing (Html)


type alias View a b =
    a -> Html (Action b)


nested : (a -> b) -> Html (Action a) -> Html (Action b)
nested predicate =
    Html.map (Action.map predicate)
