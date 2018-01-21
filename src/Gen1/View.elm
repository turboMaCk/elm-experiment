module Gen1.View exposing (..)

import Gen1.Action as Action exposing (Action)
import Html exposing (Html)


type alias View a =
    a -> Html (Action a)


fcMonad : (a -> b -> c) -> (b -> a) -> b -> c
fcMonad f h =
    \w -> f (h w) w


nested : (a -> b) -> Html (Action a) -> Html (Action b)
nested predicate =
    Html.map (Action.map predicate)


traverse : List (View a) -> View a
traverse views =
    \state -> Html.div [] <| List.map (\i -> i state) views


viewMap : (int -> arr) -> (arr -> Html (Action int)) -> View arr
viewMap predicate =
    let
        mapFc f g =
            \x -> f (g x)
    in
    mapFc (nested predicate)


part : a -> View a -> Html (Action a)
part state view =
    view state
