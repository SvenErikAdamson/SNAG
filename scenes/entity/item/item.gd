extends StaticBody2D
class_name Item

@export var amount: int = 1
@export var item_instance: PackedScene = load("res://scenes/entity/item/item.tscn")
var in_player_distance: bool = false
@onready var sprite: Sprite2D = $ItemSprite
