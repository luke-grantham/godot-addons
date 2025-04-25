## Setup Transition Manager
- Add the TransitionManager scene as an autoload

## Setup Transitions
- Setup Transition scenes with the transition.gd script
- Transition scenes must have $AnimationPlayer
- That $AnimationPlayer needs the transitions "to_black" and "to_game"


## Use
`TransitionManager.to_black("IrisWipe")`
`TransitionManager.to_game("IrisWipe")`
`TransitionManager.set_black("IrisWipe")`
`TransitionManager.set_game("IrisWipe")`
