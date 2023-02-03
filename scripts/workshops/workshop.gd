extends StaticBody2D
class_name WorkShop

@export var input_area: NodePath
@export var output_spot:NodePath


@export var takes: Resource
@export var produces: Resource

@export var level: int
@export var progress: float
@export var mltplr: float
@export var production_time: float
@export var input_required: bool = false

@onready var item = load("res://scenes/item/Item.tscn")
@onready var output: Marker2D = get_node(output_spot)
@onready var input: Area2D = get_node(input_area)

var is_focused: bool = false
var relevant_person = null
var full: bool = false
var in_progress: bool = false



func start_production():
	if !full and !in_progress:
		await get_tree().create_timer(production_time).timeout
		full = true
		in_progress = false
		create_item()
	


func create_item():
	var item_instance = item.instantiate()
	item_instance.item = produces
	item_instance.global_position = output.global_position

	get_parent().add_child(item_instance)
	full = false
	
func _process(_delta):
	if is_focused:
		set_modulate(Color(0.5, 1, 0.5, 1))
	elif !is_focused:
		set_modulate(Color(1, 1, 1, 1))

