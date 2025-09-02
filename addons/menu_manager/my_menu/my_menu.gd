class_name MyMenu
extends Control

signal activate_started()
signal activate_finished()
signal deactivate_started()
signal deactivate_finished()

@export var menu_type: MenuManager.MenuGroup

func _ready() -> void:
    MenuManager.register(self)
    # if you override _ready call super() in the overridden _ready function

func activate():
    if !visible:
        activate_started.emit()
        show()
        activate_finished.emit()

func deactivate():
    if visible:
        deactivate_started.emit()
        hide()
        deactivate_finished.emit()
