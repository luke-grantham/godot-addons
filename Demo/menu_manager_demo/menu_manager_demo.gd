extends Node2D


func _ready() -> void:
    MenuManager.menu_activate_started.connect(func(x): print("activate started for menu type " + MyUtil.enum_name(MenuManager.MenuGroup, x)))
    MenuManager.menu_activate_finished.connect(func(x): print("activate finished for menu type " + MyUtil.enum_name(MenuManager.MenuGroup, x)))
    MenuManager.menu_deactivate_started.connect(func(x): print("deactivate started for menu type " + MyUtil.enum_name(MenuManager.MenuGroup, x)))
    MenuManager.menu_deactivate_finished.connect(func(x): print("deactivate finished for menu type " + MyUtil.enum_name(MenuManager.MenuGroup, x)))

    $CanvasLayer/ButtonContainer/ShowSettings.pressed.connect(func(): MenuManager.activate_menu(MenuManager.MenuGroup.Settings))
    $CanvasLayer/ButtonContainer/HideSettings.pressed.connect(func(): MenuManager.deactivate_menu(MenuManager.MenuGroup.Settings))

    $CanvasLayer/ButtonContainer/ShowCredits.pressed.connect(func(): MenuManager.activate_menu(MenuManager.MenuGroup.Credit))
    $CanvasLayer/ButtonContainer/HideCredits.pressed.connect(func(): MenuManager.deactivate_menu(MenuManager.MenuGroup.Credit))

    $CanvasLayer/ButtonContainer/ShowMulti.pressed.connect(func(): MenuManager.activate_menu(MenuManager.MenuGroup.MultiExample))
    $CanvasLayer/ButtonContainer/HideMulti.pressed.connect(func(): MenuManager.deactivate_menu(MenuManager.MenuGroup.MultiExample))

    $CanvasLayer/ButtonContainer/HideAll.pressed.connect(func(): MenuManager.deactivate_all())

    $CanvasLayer/ButtonContainer/ShowSettingsHideOthers.pressed.connect(func(): MenuManager.activate_menu(MenuManager.MenuGroup.Settings, true))
