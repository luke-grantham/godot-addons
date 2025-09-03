### SceneManager

#### Switch scenes with a single line of code using shader-based transitions

`SceneManager.load_scene(MyScenes.SceneId.MainMenu)`

- Update MyScenes (my_scenes.gd) with your scene names
- set SceneManager node as an autoload
- add SceneData to the export variable on SceneManager
- Each SceneData represents a scene to switch to
- Transitions are optional (they use my TransitionManager addon)