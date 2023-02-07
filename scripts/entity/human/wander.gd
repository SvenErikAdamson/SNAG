extends State

@export var wander_range = 64
@onready var human = owner as Human
@onready var start_position = owner.global_position
@onready var target_position = owner.global_position
@onready var timer = $Timer

func enter(_msg := {}) -> void:
	print(human.global_position)
	pass
	



func _process(delta):
	var human_pos = human.global_position
	var direction = human_pos.direction_to(target_position)
	human.velocity = direction* human.speed * delta
	human.move_and_slide()

	

func update_target():
	var target_vector = Vector2(randf_range(-wander_range, wander_range), randf_range(-wander_range, wander_range))
	target_position = start_position + target_vector

func time_left():
	return timer.time_left

func set_timer(duration: int):
	timer.start(duration)
	
func _on_timer_timeout():
	update_target()
