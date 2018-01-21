module Gen4.Action exposing (..)


type Action a b
    = Action (a -> b)


action : (a -> b) -> Action a b
action f =
    Action f


update : Action a a -> a -> a
update (Action f) a =
    f a

mapFc : (a -> b) -> (c -> a) -> c -> b
mapFc f g =
    \x -> f (g x)

comapFc : (b -> a) -> (a -> c) -> b -> c
comapFc f g =
    g << f


map : (b -> c) -> Action a b -> Action a c
map f (Action g) =
    Action <| mapFc f g


cmap : (b -> a) -> Action a c -> Action b c
cmap f (Action g) =
    Action <| comapFc f g
