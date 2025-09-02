extends MyMenu

func _ready() -> void:
    super()

func activate():
    if !visible:
        show()
        activate_started.emit()
        var tween: Tween = create_tween()
        tween.tween_property(self, "modulate", Color(1,1,1,1), 2)
        tween.finished.connect(
            func():
                activate_finished.emit()
        )

func deactivate():
    if visible:
        deactivate_started.emit()
        var tween: Tween = create_tween()
        tween.tween_property(self, "modulate", Color(1,1,1,0), 2)
        tween.finished.connect(
            func():
                deactivate_finished.emit()
                hide()
        )
