module Examples.Gen1 exposing (..)

import Array exposing (Array)
import Gen1.Action as Action exposing (Action)
import Gen1.App as App exposing (App)
import Gen1.View as View exposing (View)
import Html
import Html.Events as Events


removeIndex : Int -> Array a -> Array a
removeIndex index array =
    Array.append (Array.slice 0 index array) (Array.slice (index + 1) (Array.length array) array)


main : App (Array Int)
main =
    App.start view <| Array.fromList [ 0 ]


addCounter : View (Array Int)
addCounter array =
    Html.button [ Events.onClick <| Action.action (Array.push 0) array ]
        [ Html.text "add counter" ]


view : View (Array Int)
view array =
    Html.main_ []
        [ addCounter array
        , counters array
        ]


counters : View (Array Int)
counters array =
    let
        update index maybe =
            case maybe of
                Just newVal ->
                    Array.set index newVal array

                Nothing ->
                    removeIndex index array

        itemView index value =
            counter value
                |> View.nested (update index)
    in
    Array.indexedMap (\i -> itemView i << Just) array
        |> Array.toList
        |> Html.div []


counter : View (Maybe Int)
counter maybe =
    case maybe of
        Just state ->
            Html.div []
                [ Html.br [] []
                , Html.button [ Events.onClick <| Action.action (Just << flip (-) 1) state ] [ Html.text "-" ]
                , Html.text (toString state)
                , Html.button [ Events.onClick <| Action.action (Just << (+) 1) state ] [ Html.text "+" ]
                , Html.button [ Events.onClick <| Action.action (always Nothing) maybe ] [ Html.text "remove" ]
                ]

        Nothing ->
            Html.text ""
