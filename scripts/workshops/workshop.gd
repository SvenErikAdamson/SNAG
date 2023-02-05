extends StaticBody2D
class_name WorkShop


@export var machine_name: String = ""
@export var input_area: 		NodePath
@export var output_spot:		NodePath
@export var sprite: NodePath

@export_group("Production")
@export var takes_list: 		Array[Resource]
@export var produces_list:		Array[Resource]
@export var production_time: 	float

@export_group("Levels & Upgrades")
@export var progress: 			float
@export var upgrades: Array[Dictionary]
@export_group("")






@export var input_required: 	bool
@export var endless_production: bool
@export var active: 			bool

@export_multiline var hover_text: String

@onready var item_scene					 		= load("res://scenes/item/Item.tscn")
@onready var output: 			Marker2D 	= get_node(output_spot)
@onready var input: 			Area2D 		= get_node(input_area)
@onready var machine_sprite: AnimatedSprite2D = get_node(sprite)

var relevant_person							 = null
var is_focused:					bool		 = false
var is_full: 					bool		 = false
var in_progress: 				bool		 = false

var level: int = 0

signal update_ui(upgrades_sent)
signal level_up(name_m, lvl)

func _ready():
	level_up.emit(machine_name, level)
	update_ui.emit(upgrades[level])
	if endless_production:
		start_production_cycle()

func player_interaction():
	if Input.is_action_just_pressed("interact") and relevant_person != null and can_interact(relevant_person.item_carried) and relevant_person.item_carried != null:
		var type = check_interaction_type(relevant_person.item_carried)
		match type:
			1: 
				relevant_person.item_into_machine()
				start_production_cycle()
			2:
				var can_upgrade = upgrade_check(relevant_person.item_carried)
				if can_upgrade:
					SoundManager.play_sound(SoundManager.TILL)
					relevant_person.item_into_machine()
					update_ui.emit(upgrades[level])
					
			3: 
				print("Something is wrong")
				
				
func can_interact(item):
	if takes_list.has(item) or upgrades[level].has(item) and relevant_person.item_carried != null :
		return true
	else:
		print("nothing")
		return false
		
func check_interaction_type(item):
	if takes_list.has(item):
		return 1
	if upgrades[level].has(item):
		return 2
	else:
		return 3
		
func upgrade_check(item):
	check_if_lvl()
	if !upgrades[level].is_empty():
		if upgrades[level].has(item):
			if upgrades[level].get(item) == 0:
				upgrades[level].erase(item)
				update_ui.emit(upgrades[level])
			
			elif upgrades[level].get(item) > 0:
				upgrades[level][item] -= 1
				if upgrades[level].get(item) == 0:
					upgrades[level].erase(item)
				update_ui.emit(upgrades[level])
				return true
	update_ui.emit(upgrades[level])
	check_if_lvl()

func check_if_lvl():
	if upgrades[level].is_empty():
		level +=1
		print("level up!")
		update_ui.emit(upgrades[level])
		level_up.emit(machine_name, level)
	
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
	
## modulates everything, should get the sprite & only modualte that, ideally maybe only outline then.
func focus_workshop():
	if is_focused:
		machine_sprite.modulate = (Color(0.5, 1, 0.5, 1))
	elif !is_focused:
		machine_sprite.modulate = (Color(1, 1, 1, 1))


