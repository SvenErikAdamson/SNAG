extends State

@onready var human = owner as Human
@onready var timer = $Timer

func enter(_msg := {}) -> void:
	human.speed = 250
	
func _physics_process(delta):
	if human.trapped == true:
		state_machine.transition_to("Trapped")
	elif human.danger_element != null:
		var direction = human.global_position.direction_to(-human.danger_element.global_position)
		human.velocity = direction* human.speed* human.acceleration * delta 
		human.move_and_slide()
	if !human.alarmed:
		timer.start(3)

func _on_timer_timeout():
	human.alarmed == false
	state_machine.transition_to(get_random_state(["Idle", "Wander"]))


