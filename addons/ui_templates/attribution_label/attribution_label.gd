@tool
class_name AttributionLabel
extends RichTextLabel


@export var attribution_data: AttributionData

func _ready() -> void:
	if attribution_data == null:
		return

	clear()
	push_bold()
	add_text(attribution_data.title)
	pop()
	add_text(" by " + attribution_data.author)
	newline()
	push_underline()
	push_meta(attribution_data.source_link) # Makes "Source" clickable
	add_text("Source")
	pop() # pop_meta
	pop() # pop_underline
	add_text(" - " + attribution_data.licence)

	connect("meta_clicked", Callable(self, "_on_meta_clicked"))

func _on_meta_clicked(meta):
	OS.shell_open(str(meta))
