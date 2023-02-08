extends State

@onready var human = owner

func enter(_msg := {}) -> void:
	human.speed = 0
	owner.velocity = Vector2.ZERO
	human.animation_player.play("idle_front")

func _physics_process(delta):
		if human.alarmed and !human.trapped:
			state_machine.transition_to("Alarmed")
		if human.trapped:
			state_machine.transition_to("Trapped")
		if human.wander.time_left() == 0:
			human.wander.set_timer(randf_range(1,5))
			state_machine.transition_to(get_random_state(["Idle", "Wander"]))
		else:
			owner.velocity = Vector2.ZERO
			


