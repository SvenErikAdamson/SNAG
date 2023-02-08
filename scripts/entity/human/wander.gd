extends State

@export var wander_range = 42
@onready var human = owner as Human
@onready var start_position = owner.global_position
@onready var target_position = owner.global_position
@onready var timer = $Timer

func enter(_msg := {}) -> void:
	pass

func _process(delta):
	if human.alarmed == true:
		state_machine.transition_to("Alarmed")
	
	var human_pos = human.global_position
	var direction = human_pos.direction_to(target_position)

	human.velocity = direction* human.speed *human.acceleration* delta
	human.move_and_slide()
#	await get_tree().create_timer(randf_range(1,3)).timeout
#	var random_state = get_random_state(["Idle", "Wander"])
#	state_machine.transition_to(random_state)

func update_target():
	var target_vector = Vector2(randf_range(-wander_range, wander_range), randf_range(-wander_range, wander_range))
	target_position = start_position + target_vector

func time_left():
	return timer.time_left

func set_timer(duration: int):
	timer.start(duration)
	
func _on_timer_timeout():
	update_target()
