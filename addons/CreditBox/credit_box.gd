@tool
class_name CreditBox
extends GridContainer

@export var credits: Array[CreditData]

func _ready() -> void:
    for credit in credits:
        addCredit(credit)

func addCredit(credit: CreditData):
    var name_label := Label.new()
    name_label.text = credit.credit_name
    name_label.horizontal_alignment = HorizontalAlignment.HORIZONTAL_ALIGNMENT_LEFT
    name_label.vertical_alignment = VerticalAlignment.VERTICAL_ALIGNMENT_CENTER

    var role_label := Label.new()
    role_label.text = credit.role
    role_label.horizontal_alignment = HorizontalAlignment.HORIZONTAL_ALIGNMENT_CENTER
    role_label.vertical_alignment = VerticalAlignment.VERTICAL_ALIGNMENT_CENTER

    var icon := TextureRect.new()
    icon.texture = credit.icon
    icon.expand_mode = TextureRect.EXPAND_FIT_WIDTH
    icon.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED

    add_child(icon)
    add_child(name_label)
    add_child(role_label)
