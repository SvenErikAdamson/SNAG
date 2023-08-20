extends CharacterBody2D

@export var acceleration := 10.0
@export var max_speed := 100
@export var rotate_speed := 100.0
var drone_used: bool = false

func _physics_process(delta):
	if drone_used:
		var input_vector := Vector2(0,Input.get_axis("move_up", "move_down"))
		
		velocity += input_vector.rotated(rotation) * acceleration
		velocity = velocity.limit_length(max_speed)
		
		if Input.is_action_pressed("move_right"):
			rotate(deg_to_rad(rotate_speed* delta))
		if Input.is_action_pressed("move_left"):
			rotate(deg_to_rad(-rotate_speed* delta))
			
		if input_vector.y == 0:
			velocity = velocity.move_toward(Vector2.ZERO, 3)
			
		move_and_slide()
	
	
