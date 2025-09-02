extends Node

## Emitted when the menu group starts activating
signal menu_activate_started(menu_type: MenuGroup)
## Emitted when the menu group is done activating
signal menu_activate_finished(menu_type: MenuGroup)
## Emitted when the menu group starts deactivating
signal menu_deactivate_started(menu_type: MenuGroup)
## Emitted when the menu group is done deactivating
signal menu_deactivate_finished(menu_type: MenuGroup)

enum MenuGroup {
    Settings,
    Credit,
    MultiExample
}


var _menu_dict: Dictionary = {}

func _ready() -> void:
    for key in range(0, MenuGroup.size()):
        _menu_dict[key] = []

## Register a menu so the MenuManager can start managing that menu
func register(menu):
    if menu.get("menu_type") != null:
        _menu_dict[menu.menu_type].append(menu)
        menu.activate_started.connect(func(): menu_activate_started.emit(menu.menu_type))
        menu.activate_finished.connect(func(): menu_activate_finished.emit(menu.menu_type))
        menu.deactivate_started.connect(func(): menu_deactivate_started.emit(menu.menu_type))
        menu.deactivate_finished.connect(func(): menu_deactivate_finished.emit(menu.menu_type))
    else:
        printerr("Can't register menu: %s" % menu.name)

## Activate menus with the given MenuGroup
func activate_menu(menu_type: MenuGroup, hide_others: bool = false):
    for menu in _menu_dict[menu_type]:
        menu.activate()

    if hide_others:
        print(range(0,MenuGroup.size()))
        print(menu_type)
        print(range(0,MenuGroup.size()).filter(func(k): return k != menu_type))
        for key in range(0, MenuGroup.size()).filter(func(k): return k != menu_type):
            print("here")
            deactivate_menu(key)

## Deactivate menus with the given MenuGroup
func deactivate_menu(menu_type: MenuGroup):
    for menu in _menu_dict[menu_type]:
        menu.deactivate()

## Deactivate all menus registered to the MenuManager
func deactivate_all():
    for key in range(0, MenuGroup.size()):
        deactivate_menu(key)
