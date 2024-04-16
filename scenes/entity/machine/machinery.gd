extends StaticBody2D
class_name Machinery

@export var output: Item
@export var recipe: Array[Item]
@export var required: Array[Item]
@export var storage: Array[Item]
@export var build_time: int
@export var is_online: bool = false

var focused_item: Item =  null

var is_full: bool = false
var is_building: bool = false

func _is_it_valid_item(item: Item) -> bool:
	if recipe.has(item):
		required.erase(item)
		return true
	return false
	
func _item_input(item: Item) -> void:
	if _is_it_valid_item(item):
		print("Item is valid")
		

func _build() -> void:
	pass



func _on_input_body_entered(body: Node2D) -> void:
	if body.is_in_group("Items"):
		focused_item = body
		print(focused_item)

func _on_input_body_exited(body: Node2D) -> void:
	if body is Item:
		focused_item = null
