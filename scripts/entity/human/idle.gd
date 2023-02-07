extends State

@onready var human = owner




func enter(_msg := {}) -> void:
	pass
	
func _physics_process(delta):
		owner.velocity = Vector2.ZERO.move_toward(Vector2.ZERO, human.friction * delta)
		if human.wander.time_left() == 0:
			var random_state = get_random_state(["Idle", "Wander"])
			human.wander.set_timer(randf_range(1,4))
			state_machine.transition_to(random_state)
			


