extends Resource
class_name BaseItem

@export var item_name: String
@export var item_texture: Texture
@export var quantity: int
@export var weight: int
@export var value: int

@export_multiline var hover_text: String



func get_texture() -> Texture:
	return item_texture

func get_hover_text() -> String:
	return hover_text

func interact():
	pass
	
