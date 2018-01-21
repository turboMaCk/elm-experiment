This repository implements very experimental abstractions that are not meant to be use for anything else than for experimentation.
If you're not primary interested in playing with crazy ideas stay out.

This repository contains experiments with abstraction build on top of TEA mainly in direction of briging more composiveness
in exchange for other fuctions. Right now I'm playing with elimination of what is usually called `Msg` and `update`.
With just a `view` composition is much simpler.

This is just an exrcise at this point with no abition in becoming more than that.

# Examples

This type of abstraction let's you to implement classic counter example like this:


```elm
import Gen1.Action as Action exposing (Action)
import Gen1.App as App exposing (App)
import Gen1.View as View exposing (View)
import Html exposing (Html)
import Html.Events as Events

main : App Int
main =
    App.start view 0

view : View Int
view state =
    Html.div []
        [ Html.button [ Events.onClick <| Action.action (flip (-) 1) state ] [ Html.text "-" ]
        , Html.text (Basics.toString state)
        , Html.button [ Events.onClick <| Action.action ((+) 1) state ] [ Html.text "+" ]
        ]
```

See [examples](/examples) for more info.
