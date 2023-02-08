extends RigidBody2D
class_name Item

@export var item: Resource: set = _set_item
@onready var outline_shader= load("res://scenes/item/Item.gdshader")

var is_focused: bool = false
var in_hand: bool
var holder = null
var sprite = null
var hover_text: String



func _set_item(new_item: Resource):
	item = new_item
	sprite = item.get_texture()
	$Sprite2D.texture = item.get_texture()
	hover_text  = item.get_hover_text()


func _physics_process(_delta):
	if is_focused:
		set_modulate(Color(0.5, 1, 0.5, 1))
	elif !is_focused:
		set_modulate(Color(1, 1, 1, 1))




