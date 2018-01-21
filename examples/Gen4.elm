module Gen4 exposing (..)

import Array exposing (Array)
import Gen4.Action as Action exposing (Action)
import Gen4.App as App exposing (App)
import Gen4.View as View exposing (View)
import Html
import Html.Events as Events


removeIndex : Int -> Array a -> Array a
removeIndex index array =
    Array.append (Array.slice 0 index array) (Array.slice (index + 1) (Array.length array) array)


main : App (Array Int)
main =
    App.start view <| Array.fromList [ 0 ]


view : View (Array Int) (Array Int)
view state =
    Html.div []
        [ addCounter state
        , counters state
        ]


addCounter : View (Array Int) (Array Int)
addCounter _ =
    Html.button [ Events.onClick <| Action.action (\arr -> Array.push (Array.length arr) arr) ]
        [ Html.text "add new" ]


counters : View (Array Int) (Array Int)
counters state =
    let
        update index maybe =
            case maybe of
                Just newVal ->
                    Array.set index newVal state

                Nothing ->
                    removeIndex index state

        itemView index =
            View.nested (\value -> ( always value, update index )) counter
    in
    Array.indexedMap itemView state
        |> Array.toList
        |> Html.div []


counter : View Int (Maybe Int)
counter state =
    Html.div []
        [ Html.button [ Events.onClick <| Action.action (Just << flip (-) 1) ] [ Html.text "-" ]
        , Html.text <| toString state
        , Html.button [ Events.onClick <| Action.action (Just << (+) 1) ] [ Html.text "+" ]
        , Html.button [ Events.onClick <| Action.action (always Nothing) ] [ Html.text "remove" ]
        ]
