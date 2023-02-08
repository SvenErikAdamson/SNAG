extends "res://scenes/item/classes/item_class.gd"
class_name AliveItem
@export var animation: AnimatedSprite2D
@export var alive: bool




func get_animation() -> AnimatedSprite2D:
	return animation
