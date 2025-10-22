extends Node2D


func _ready() -> void:
	MenuManager.menu_activate_started.connect(func(x): print("menu_activate_started for menu type " + MyUtil.enum_name(MenuConstants.MenuGroup, x)))
	MenuManager.menu_activate_finished.connect(func(x): print("menu_activate_finished for menu type " + MyUtil.enum_name(MenuConstants.MenuGroup, x)))
	MenuManager.menu_deactivate_started.connect(func(x): print("menu_deactivate_started for menu type " + MyUtil.enum_name(MenuConstants.MenuGroup, x)))
	MenuManager.menu_deactivate_finished.connect(func(x): print("menu_deactivate_finished for menu type " + MyUtil.enum_name(MenuConstants.MenuGroup, x)))

	$CanvasLayer/ButtonContainer/ShowSettings.pressed.connect(func(): MenuManager.activate_menu(MenuConstants.MenuGroup.Settings))
	$CanvasLayer/ButtonContainer/HideSettings.pressed.connect(func(): MenuManager.deactivate_menu(MenuConstants.MenuGroup.Settings))

	$CanvasLayer/ButtonContainer/ShowCredits.pressed.connect(func(): MenuManager.activate_menu(MenuConstants.MenuGroup.Credit))
	$CanvasLayer/ButtonContainer/HideCredits.pressed.connect(func(): MenuManager.deactivate_menu(MenuConstants.MenuGroup.Credit))

	$CanvasLayer/ButtonContainer/ShowMulti.pressed.connect(func(): MenuManager.activate_menu(MenuConstants.MenuGroup.MultiExample))
	$CanvasLayer/ButtonContainer/HideMulti.pressed.connect(func(): MenuManager.deactivate_menu(MenuConstants.MenuGroup.MultiExample))

	$CanvasLayer/ButtonContainer/HideAll.pressed.connect(func(): MenuManager.deactivate_all())

	$CanvasLayer/ButtonContainer/ShowSettingsHideOthers.pressed.connect(func(): MenuManager.activate_menu(MenuConstants.MenuGroup.Settings, true))

	$CanvasLayer/ButtonContainer/ReloadScene.pressed.connect(
		func():
			MenuManager.clear()
			get_tree().reload_current_scene()

	)

	%ReloadSceneButton.pressed.connect(func(): get_tree().reload_current_scene())

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_released("debug"):
		MenuManager.debug()
