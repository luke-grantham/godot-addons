extends PanelContainer

signal click_count_updated(num: int)

var click_count: int = 0

func _process(_delta: float) -> void:
	if Input.is_anything_pressed():
		click_count+=1
		click_count_updated.emit(click_count)
