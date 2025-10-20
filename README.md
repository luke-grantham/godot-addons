# Godot Game Engine Addons (v4.x)

### How to use
Copy directories in the addons directory to the addons directory in your own project.
For directions on using individual addons, see README.md in each addon directory

# Current Addons
### Transition Manager
- Manage scene transitions (fade to black, etc)
- Includes IrisWipe shader-based transition

### VolumeControl and AudioManager
- Control node that can be used for Master / Music / SFX volume
- Must be used with AudioManager

### Credit Box
For showing credits. Saves some time setting up all the control nodes.

### ControlWiggleComponent
Add this to a Control node to make it wiggle when you mouse over it.

### ReactiveButtonComponent
Add this to a Button to make it change size on hover and press

### Interpolation Controllers
Interpolate float values over time

### MyUtil
Some helpful static functions 

### MenuManager
Manage groups of Control nodes. Useful for transitioning to/from separate menus or animating ui in and out of view

### SceneManager
Switch scenes with a single line of code using shader-based transitions.

`SceneManager.load_scene(MyScenes.SceneId.MainMenu)`

Requires: TransitionManager, MyUtil


### UI Templates
Templates for various ui elements commonly needed. Start buttons, credits, settings, etc.


### ConfirmButton
Button that asks for confirmation on pressed.

### Shaders
Includes CC0 universal transition shader copied here for my convenience: https://github.com/cashew-olddew/Universal-Transition-Shader

### MainMenuCamera3D
Camera for 3D menus that slightly rotates the camera based on your mouse position
