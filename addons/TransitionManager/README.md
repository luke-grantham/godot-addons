## Setup Transition Manager
- Add the TransitionManager scene as an autoload

## Setup Transitions
- Setup Transition scenes with the transition.gd script
- Transition scenes must have $AnimationPlayer
- That $AnimationPlayer needs the transitions "to_black" and "to_game"


## Use
Start the transitions with `to_black` and `to_game`.

Go instantly to the end of a transition with `set_black` and `set_game`
```
# IrisWipe is the name of the node that the transition.gd script is attached to.
TransitionManager.to_black("IrisWipe")
TransitionManager.to_game("IrisWipe")
TransitionManager.set_black("IrisWipe")
TransitionManager.set_game("IrisWipe")
```
Subscribe to the `transition_done` signal.
```asm
func _ready() -> void:
    TransitionManager.transition_done.connect(on_transition_done)

func on_transition_done(transition_name, animation_name):
    print("Transition %s , Animation %s DONE" % [transition_name, animation_name])
```