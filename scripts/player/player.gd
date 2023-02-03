class_name Player
extends CharacterBody2D

@onready var animated_sprite: 			AnimatedSprite2D 	= $AnimatedSprite2D
@onready var carried_sprite: 			Sprite2D 			= $CarriedObject
@onready var item_prefab 									= load("res://scenes/item/Item.tscn")


var speed: 								int 				= 120
var acceleration: 						int 				= 50
var friction: 							int 				= 20

var objects_around: 					Array
var object_focus											= null
var item_carried 											= null
var hands_full 												= false

func ready():
	set_velocity(Vector2.ZERO)


func _physics_process(_delta):
	if Input.is_action_just_pressed("swap_focus"):
		change_focus(object_focus)
	if Input.is_action_just_pressed("interact") and !hands_full and object_focus is Item:
		item_pickup(object_focus)
	elif Input.is_action_just_pressed("drop") and hands_full:
		item_drop()

func item_pickup(item):
	if item != null and !objects_around.is_empty():
		item_carried = item.item
		if !objects_around.is_empty():
			object_focus = objects_around.front()
		change_focus(object_focus)
		carried_sprite.texture = item.sprite
		carried_sprite.show()
		item.queue_free()
		hands_full = true

func item_drop():
	object_focus = null
	var item_instance = item_prefab.instantiate()
	item_instance.item =  item_carried
	get_parent().add_child(item_instance)
	item_instance.global_position = global_position
	carried_sprite.hide()
	hands_full = false
	
func item_into_machine():
	carried_sprite.hide()
	hands_full = false
	
func swap_item():
	pass

func change_focus(current_focus):

	if current_focus != null:
		var index = objects_around.find(current_focus)
		current_focus.is_focused = false
		index += 1
		if !objects_around.is_empty():
			if index > objects_around.size() - 1 :
				index = 0
				objects_around[index].is_focused = true
				object_focus = objects_around[index]

			else:
				objects_around[index].is_focused = true
				object_focus = objects_around[index]


#Refactor it smoll
func _on_item_detector_body_entered(body):
	if body is Item:
		object_focus = body as Item
		if !objects_around.is_empty():
			objects_around[objects_around.size() - 1].is_focused = false
		object_focus.is_focused = true
		objects_around.append(object_focus)
	elif body is WorkShop:
		object_focus = body as WorkShop
		if !objects_around.is_empty():
			objects_around[objects_around.size() - 1].is_focused = false
		object_focus.is_focused = true
		objects_around.append(object_focus)



		

func _on_item_detector_body_exited(body):
	if body != Player:
		body.is_focused = false
		objects_around.erase(body)




func get_input_direction() -> Vector2:
	var input_direction = Vector2(Input.get_action_strength("move_right") - Input.get_action_strength("move_left"), Input.get_action_strength("move_down") - Input.get_action_raw_strength("move_up"))
	if input_direction  < Vector2.ZERO:
		$AnimatedSprite2D.flip_h= true
	if input_direction  > Vector2.ZERO:
		$AnimatedSprite2D.flip_h= false
	return input_direction 