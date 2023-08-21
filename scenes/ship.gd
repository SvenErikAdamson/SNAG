extends CharacterBody2D

var destination
var speed = 100
var item_amount = 3
var item_scene = preload("res://scenes/item/Item.tscn")
var tools = preload("res://scenes/item/data/Tools.tres")
var offset = 0
var is_reached = false
var is_interactable = false

func _ready():
	pass


	
func _process(_delta):
	if position != destination and !is_reached:
		velocity = position.direction_to(destination)*speed
		move_and_slide()

	if position.distance_to(destination) < 10:
		is_reached = true
		
	if is_reached and !is_interactable:
		spawn_items()
		
			
		is_interactable = true

func spawn_items():
	for i in item_amount:
		var item = item_scene.instantiate()
		item.item = tools
		item.global_position = $CargoMarker1.global_position
		item.position.x =  $CargoMarker1.global_position.x + offset
		offset += 16
		get_parent().add_child(item)
