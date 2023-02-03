extends "res://scripts/item/classes/item_class.gd"

class_name Organ


@export var organ_value: int
@export var draggable: bool

func get_drag_state() -> bool:
	return draggable

