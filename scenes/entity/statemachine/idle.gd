extends State

@onready var human = owner




func enter(_msg := {}) -> void:
	owner.velocity = Vector2.ZERO
	human.animation_player.play("idle_front")

	
func _physics_process(delta):

		if human.alarmed == true:
			state_machine.transition_to("Alarmed")
		if human.trapped == true:
			state_machine.transition_to("Trapped")
		if human.wander.time_left() == 0:
			var random_state = get_random_state(["Idle", "Wander"])
			human.wander.set_timer(randf_range(1,5))
			state_machine.transition_to(random_state)
		else:
			owner.velocity = Vector2.ZERO.move_toward(Vector2.ZERO, human.friction * delta)
			


