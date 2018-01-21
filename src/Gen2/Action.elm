module Gen2.Action exposing (..)


type Action model
    = Action (() -> model)


update : Action model -> model -> model
update (Action action) _ =
    action ()


action : (a -> model) -> a -> Action model
action constructor a =
    Action <| \() -> constructor a


map : (a -> b) -> Action a -> Action b
map predicate (Action constructor) =
    Action <| predicate << constructor
