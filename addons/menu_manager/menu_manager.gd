extends Node

## Emitted when the menu group starts activating
signal menu_activate_started(menu_group: MenuGroup)
## Emitted when the menu group is done activating
signal menu_activate_finished(menu_group: MenuGroup)
## Emitted when the menu group starts deactivating
signal menu_deactivate_started(menu_group: MenuGroup)
## Emitted when the menu group is done deactivating
signal menu_deactivate_finished(menu_group: MenuGroup)

enum MenuGroup {
	Settings,
	Credit,
	MultiExample
}


var _menu_dict: Dictionary = {}

func _ready() -> void:
	_init_menu_dict()

func _bubble_as(menu_group: MenuGroup):
	menu_activate_started.emit(menu_group)
func _bubble_af(menu_group: MenuGroup):
	menu_activate_finished.emit(menu_group)
func _bubble_ds(menu_group: MenuGroup):
	menu_deactivate_started.emit(menu_group)
func _bubble_df(menu_group: MenuGroup):
	menu_deactivate_finished.emit(menu_group)

## Register a menu so the MenuManager can start managing that menu
func register(menu):
	if menu.get("menu_group") != null:
		print("MenuManager ::: Registering %s on %s" % [menu.name, menu.parent.name])
		menu.tree_exiting.connect(_on_menu_effect_exiting.bind(menu))
		_menu_dict[menu.menu_group].append(menu)
		menu.activate_started.connect(_bubble_as.bind(menu.menu_group))
		menu.activate_finished.connect(_bubble_af.bind(menu.menu_group))
		menu.deactivate_started.connect(_bubble_ds.bind(menu.menu_group))
		menu.deactivate_finished.connect(_bubble_df.bind(menu.menu_group))
	else:
		printerr("Can't register menu: %s" % menu.name)

## Activate menus with the given MenuGroup
func activate_menu(menu_group: MenuGroup, hide_others: bool = false):
	for menu in _menu_dict[menu_group]:
		menu.activate()

	if hide_others:
		for key in range(0, MenuGroup.size()).filter(func(k): return k != menu_group):
			deactivate_menu(key)

## Deactivate menus with the given MenuGroup
func deactivate_menu(menu_group: MenuGroup):
	for menu in _menu_dict[menu_group]:
		menu.deactivate()

## Deactivate all menus registered to the MenuManager
func deactivate_all():
	for key in range(0, MenuGroup.size()):
		deactivate_menu(key)

func _init_menu_dict():
	for key in range(0, MenuGroup.size()):
		_menu_dict[key] = []

func _on_menu_effect_exiting(menu: MenuEffect):
	_menu_dict[menu.menu_group].erase(menu)

func debug():
	print("----- Menu Manager DEBUG -----")
	for key in _menu_dict:
		print("%s : %s" % [ str(key), str(_menu_dict[key]) ])
	print("----------")
