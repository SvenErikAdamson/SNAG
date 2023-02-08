extends State


@onready var human = owner as Human
@onready var timer = $Timer

func _physics_process(delta):
	if human.danger_element != null:
		var direction = human.global_position.direction_to(-human.danger_element.global_position)
		human.velocity = direction* human.speed*5 *human.acceleration* delta
		human.move_and_slide()
	if !human.alarmed:
		timer.start(3)

func _on_timer_timeout():
	var random_state = get_random_state(["Idle", "Wander"])
	human.alarmed == false
	state_machine.transition_to(random_state)


