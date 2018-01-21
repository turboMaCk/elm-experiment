module Gen3.Action exposing (..)


type Action a
    = Action (() -> ( a, Cmd (Action a) ))


update : Action a -> a -> ( a, Cmd (Action a) )
update (Action f) _ =
    f ()


action : (a -> b) -> a -> Action b
action f a =
    Action <| \() -> ( f a, Cmd.none )


mapFc : (a -> b) -> (c -> a) -> c -> b
mapFc f g =
    \x -> f (g x)


addCmd : Cmd (Action a) -> Action a -> Action a
addCmd cmd (Action f) =
    Action <| mapFc (\( a, c ) -> ( a, Cmd.batch [ c, cmd ] )) f


map : (a -> b) -> Action a -> Action b
map predicate (Action constructor) =
    Action <| (\( s, cmd ) -> ( predicate s, Cmd.map (map predicate) cmd )) << constructor
