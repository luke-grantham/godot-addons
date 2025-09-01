class_name MyUtil
extends Object

## Prints the name of the enum
static func enum_name(enum_dict: Dictionary, value: int) -> String:
    for name in enum_dict.keys():
        if enum_dict[name] == value:
            return name
    return "Unknown"
