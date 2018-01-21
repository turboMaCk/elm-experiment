module Gen4.View exposing (..)

import Gen4.Action as Action exposing (Action)
import Html exposing (Html)


type alias View a b =
    a -> Html (Action a b)


map : (b -> c) -> Html (Action a b) -> Html (Action a c)
map f =
    Html.map (Action.map f)


cmap : (b -> a) -> Html (Action a c) -> Html (Action b c)
cmap f =
    Html.map (Action.cmap f)


nested : (a -> ( c -> a, b -> d )) -> View a b -> a -> Html (Action c d)
nested c view a =
    let
        ( f, g ) =
            c a
    in
    view a
        |> cmap f
        |> map g
