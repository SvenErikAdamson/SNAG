extends StaticBody2D
class_name WorkShop



@export var input_area: 		NodePath
@export var output_spot:		NodePath

@export_group("Production")
@export var takes_list: 		Array[Resource]
@export var produces_list:		Array[Resource]
@export var production_time: 	float

@export_group("Upgrades")
@export var level: 				int
@export var progress: 			float
@export var upgrades: Array[Dictionary]
@export_group("")






@export var input_required: 	bool
@export var endless_production: bool
@export var active: 			bool

@export_multiline var hover_text: String

@onready var workshop_info_instance				= preload("res://scenes/ui/WorkShopInfo.tscn")
@onready var item_scene					 		= load("res://scenes/item/Item.tscn")
@onready var output: 			Marker2D 	= get_node(output_spot)
@onready var input: 			Area2D 		= get_node(input_area)

var workshop_info
var relevant_person							 = null
var is_focused:					bool		 = false
var is_full: 					bool		 = false
var in_progress: 				bool		 = false

var next_level: int = 0

signal update_ui(on_update)

func _ready():
	workshop_info = workshop_info_instance.instantiate()
	add_child(workshop_info)
	workshop_info.position.y -= 70
	workshop_info.position.x -= 35
	workshop_info.parent = self
	workshop_info.update_ui.connect(self._on_update)
	workshop_info.hide()
	create_item_ui()
# Checks if player given item is in the current-upgrade path
# Moves on if upgrade complete
# Probably should split it
#func connect_signal():
#	owner.connect("update_ui",self ,"_on_upwdadte_ui")

func create_item_ui():
	if is_instance_valid(workshop_info):
		workshop_info.update_ui.emit()

#	if !upgrades[next_level].is_empty():
#		for item in upgrades[next_level].keys():
#			var text = str(upgrades[next_level].get(item))
#			var image = item.item_texture
#			workshop_info.create_item_boxes(text, image)
			
func _on_update():
	print("yooo")
	pass
#	if !upgrades[next_level].is_empty():
#		for item in upgrades[next_level].keys():
#			var text = str(upgrades[next_level].get(item))
#			var image = item.item_texture
#			workshop_info.create_item_boxes(text, image)
#
func check_item(item):
	if !upgrades[next_level].is_empty():
		if upgrades[next_level].has(item):

			if upgrades[next_level].get(item) <= 0:
				upgrades[next_level].erase(item)

			else:
				upgrades[next_level][item] -= 1
				print(upgrades[next_level].get(item))
				return true
	else:
		next_level += 1

	
# Choosing a single random item to spawn
# Chance depends on the weight the Item Resource has
func choose_item(items_array: Array = produces_list):
	var chosen_item = null
	if items_array.size() > 0:
		var overall_chance: int = 0
		for i in items_array:
			overall_chance += i.weight
			
		var r_number = randi() % overall_chance
		var _offset: int = 0
		for i in produces_list:
			if r_number < i.weight:
				chosen_item = i
				break
			else:
				_offset += i.weight
				chosen_item = i
	return chosen_item
	
	
func start_production_cycle():
	if !is_full and !in_progress:
		await get_tree().create_timer(production_time).timeout
		is_full = true
		in_progress = false
		create_item()
	
func create_item():
	var item_to_create = null
	if produces_list.size() > 1:
		item_to_create = choose_item()
	else:
		item_to_create = produces_list[0]
	var item_instance = item_scene.instantiate()
	item_instance.item = item_to_create
	item_instance.global_position = output.global_position
	get_parent().add_child(item_instance)
	is_full = false
	if endless_production:
		start_production_cycle()
	
func _process(_delta):
	focus_workshop()


## modulates everything, should get the sprite & only modualte that, ideally maybe only outline then.
func focus_workshop():
	if is_focused:
		set_modulate(Color(0.5, 1, 0.5, 1))
	elif !is_focused:
		set_modulate(Color(1, 1, 1, 1))


