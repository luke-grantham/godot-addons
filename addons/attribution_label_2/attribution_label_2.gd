@tool
class_name AttributionLabel_2
extends Control


@export var attribution_data: AttributionData
@export var attribution_label_data: AttributionLabelData
@onready var rich: RichTextLabel = %RichTextLabel
@onready var link: LinkButton = %LinkButton
@onready var license_name: Label = %LicenseName

func _ready() -> void:

    rich.add_theme_font_size_override("normal_font_size", attribution_label_data.font_size)
    rich.add_theme_font_size_override("bold_font_size", attribution_label_data.font_size)
    link.add_theme_font_size_override("font_size", attribution_label_data.font_size)
    license_name.add_theme_font_size_override("font_size", attribution_label_data.font_size)

    if attribution_data == null:
        return

    rich.clear()
    rich.push_bold()
    rich.add_text(attribution_data.title)
    rich.pop()
    rich.add_text(" by " + attribution_data.author)

    if attribution_data.source_link:
        rich.add_text("  -  ")
        link.uri = attribution_data.source_link
        link.show()
    else:
        link.hide()

    if attribution_data.licence:
        license_name.text = " -  %s" % attribution_data.licence
        license_name.show()
    else:
        license_name.hide()
