extends "res://scripts/item/classes/item_class.gd"

class_name Organ


@export var organ_value: int
@export var draggable: bool
@export var spawn_rate: int

func get_drag_state() -> bool:
	return draggable

