module Examples.Gen2 exposing (main)

import Array exposing (Array)
import Gen2.Action as Action exposing (Action)
import Gen2.App as App exposing (App)
import Gen2.View as View exposing (View)
import Html
import Html.Events as Events


removeIndex : Int -> Array a -> Array a
removeIndex index array =
    Array.append (Array.slice 0 index array) (Array.slice (index + 1) (Array.length array) array)


main : App (Array Int)
main =
    App.start view <| Array.fromList [ 0 ]


addCounter : View (Action (Array Int)) (Array Int)
addCounter action =
    Html.button [ Events.onClick action ]
        [ Html.text "add counter" ]


view : View (Array Int) (Array Int)
view state =
    Html.div []
        [ addCounter <| Action.action (Array.push 0) state
        , counters state
        ]


counters : View (Array Int) (Array Int)
counters state =
    let
        update index maybe =
            case maybe of
                Just newVal ->
                    Array.set index newVal state

                Nothing ->
                    removeIndex index state

        itemView index value =
            counter value
                |> View.nested (update index)
    in
    Array.indexedMap itemView state
        |> Array.toList
        |> Html.div []


counter : View Int (Maybe Int)
counter state =
    Html.div []
        [ Html.button [ Events.onClick <| Action.action (Just << flip (-) 1) state ] [ Html.text "-" ]
        , Html.text (Basics.toString state)
        , Html.button [ Events.onClick <| Action.action (Just << (+) 1) state ] [ Html.text "+" ]
        , Html.button [ Events.onClick <| Action.action (always Nothing) () ] [ Html.text "remove" ]
        ]
