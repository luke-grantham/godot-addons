extends Node2D

enum TestEnum {
	Name,
	Of,
	These,
	Enums
}

func _ready() -> void:
	print("--- MyUtils: enum_name ---")
	print(MyUtil.enum_name(TestEnum, 0))
	print(MyUtil.enum_name(TestEnum, TestEnum.Of))
	print(MyUtil.enum_name(TestEnum, 2))
	print(MyUtil.enum_name(TestEnum, TestEnum.Enums))
	print("------")
