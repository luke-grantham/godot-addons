class_name MenuEffect
extends Node

signal activate_started()
signal activate_finished()
signal deactivate_started()
signal deactivate_finished()

@export var menu_group: MenuManager.MenuGroup

var parent: Control

func _ready() -> void:
    parent = get_parent()
    if !parent or !(parent is Control):
        printerr("MenuEffect must have a Control node as a parent")

    MenuManager.register(self)
    # if you override _ready call super() in the overridden _ready function

## Show the menu
func activate():
    activate_started.emit()
    parent.show()
    activate_finished.emit()

## Hide the menu
func deactivate():
    deactivate_started.emit()
    parent.hide()
    deactivate_finished.emit()

## Used to help set the initial state
func set_active():
    pass

## Used to help set the initial state
func set_inactive():
    pass
