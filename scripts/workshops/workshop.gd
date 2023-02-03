extends StaticBody2D
class_name WorkShop



@export var input_area: 		NodePath
@export var output_spot:		NodePath


@export var takes_list: 		Array[Resource]
@export var takes: 				Resource
@export var produces: 			Resource

@export var level: 				int
@export var progress: 			float
@export var mltplr: 			float
@export var production_time: 	float
@export var input_required: 	bool
@export var endless_production: bool 
@export var active: 			bool

@onready var item					 		= load("res://scenes/item/Item.tscn")
@onready var output: 			Marker2D 	= get_node(output_spot)
@onready var input: 			Area2D 		= get_node(input_area)


var relevant_person							 = null
var is_focused:					bool		 = false
var is_full: 					bool		 = false
var in_progress: 				bool		 = false





func start_production():
	if !is_full and !in_progress:
		await get_tree().create_timer(production_time).timeout
		is_full = true
		in_progress = false
		create_item()
	
func item_choice():
	pass
func get_item_percentages():
	for item in takes_list:
		print("yes")
	pass
func create_item():
	var item_instance = item.instantiate()
	item_instance.item = produces
	item_instance.global_position = output.global_position
	get_parent().add_child(item_instance)
	is_full = false
	if endless_production:
		start_production()
	
func _process(_delta):
	focus_workshop()


func focus_workshop():
	if is_focused:
		set_modulate(Color(0.5, 1, 0.5, 1))
	elif !is_focused:
		set_modulate(Color(1, 1, 1, 1))

