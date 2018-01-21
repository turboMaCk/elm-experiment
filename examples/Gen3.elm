module Examples.Gen3 exposing (main)

import Array exposing (Array)
import Gen3.Action as Action exposing (Action)
import Gen3.App as App exposing (App)
import Gen3.View as View exposing (View)
import Html
import Html.Events as Events
import Http exposing (Request)


getRandom : Request String
getRandom =
    Http.getString "https://www.random.org/strings/?num=10&len=10&digits=on&unique=on&format=plain&rnd=new"


init : ( List String, Cmd (Action (List String)) )
init =
    ( [], Cmd.none )


main : App (List String)
main =
    App.start view init


view : View (List String) (List String)
view states =
    let
        update str =
            List.filter ((/=) str) states
    in
    Html.div []
        [ addNew ()
            |> View.map (Maybe.withDefault states << Maybe.map (\str -> str :: states))
        , Html.ul [] <|
            List.map (View.map update << itemView) states
        ]


itemView : View String String
itemView str =
    Html.li []
        [ Html.text str
        , Html.button [ Events.onClick <| Action.action identity str ]
            [ Html.text "remove" ]
        ]


addNew : View () (Maybe String)
addNew () =
    Html.button
        [ Action.action (always Nothing) ()
            |> Action.addCmd (Http.send (Action.action Result.toMaybe) getRandom)
            |> Events.onClick
        ]
        [ Html.text "new" ]
