module Gen1.Main exposing (..)

import Html exposing (Html)


type Action model
    = Action (() -> model)


update : Action model -> model -> model
update (Action action) _ =
    action ()


action : a -> (a -> model) -> Action model
action model constructor =
    Action <| \() -> constructor model


map : (a -> b) -> Action a -> Action b
map predicate (Action constructor) =
    Action <| predicate << constructor


type alias View a =
    a -> Html (Action a)


fcMonad : (a -> b -> c) -> (b -> a) -> b -> c
fcMonad f h =
    \w -> f (h w) w


nested : (a -> b) -> Html (Action a) -> Html (Action b)
nested predicate =
    Html.map (map predicate)


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


type alias App a =
    Program Never a (Action a)


start : View a -> a -> App a
start view state =
    Html.beginnerProgram
        { model = state
        , view = view
        , update = update
        }
