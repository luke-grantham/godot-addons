## Setup Transition Manager
- Add the TransitionManager scene as an autoload
- Two transitions are ready to use: `IrisWipe` and `FadeToBlack`
- Run the demo scene to see it in action: `Demo/TransitionManagerDemo/TransitionManagerDemo.tscn`

## Use Transitions


Transition from your game to a black screen:
```
TransitionManager.to_black("IrisWipe")
```

---
Transition from a black screen to your game:
```
TransitionManager.to_game("IrisWipe")
```
---

Bypass the transition animiation and go directly to black screen or game:
```
TransitionManager.set_black("IrisWipe")
TransitionManager.set_game("IrisWipe")
```
---

Subscribe to the `transition_done` signal.
```asm
func _ready() -> void:
    TransitionManager.transition_done.connect(on_transition_done)

func on_transition_done(transition_name, animation_name):
    print("Transition %s , Animation %s DONE" % [transition_name, animation_name])
```


## Setup Your Own Transitions
There are two ways to set up a transition. The first is with the tween based implementation
and the second is with the AnimationPlayer based implementation.


#### Tween/Shader Based Transitions
- Create a new ColorRect scene (or other Control node), set to full rect, set mouse_filter to Ignored
- Set material to ShaderMaterial and attach the shader that will be doing the transition
- Set the script as `tweened_transition.gd`
- Set the export variables on the node according to your shader
- Add your node as a child of TransitionManager


#### Animation Player based transitions
- Create a new ColorRect scene (or other Control node), set to full rect, set mouse_filter to Ignored
- Set the script as `animated_transition.gd`
- Add an AnimationPlayer as a child node
- That `$AnimationPlayer` needs the transitions "to_black" and "to_game"
- You need to make the animation happen using the AnimationPlayer. Whether that is by animating shader_parameters or
  some other way, that's up to you.
- Add your node as a child of TransitionManager
