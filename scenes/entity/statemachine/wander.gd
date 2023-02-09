extends State

@export var wander_range = 64
@onready var human = owner as Human
@onready var start_position = owner.global_position
@onready var target_position = owner.global_position
@onready var timer = $Timer

func enter(_msg := {}) -> void:
	human.speed = 100
	human.animation_player.play("move_right")
	
func _process(delta):
	if human.trapped:
		state_machine.transition_to("Trapped")
	if human.alarmed and !human.trapped:
		state_machine.transition_to("Alarmed")
	else:
		var human_pos = human.global_position
		var direction = human_pos.direction_to(target_position).normalized()
		human.sprite.flip_h = human.velocity.x < 0
		human.velocity = direction* human.speed* human.acceleration * delta 
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
