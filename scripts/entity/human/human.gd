extends Entity
class_name Human

@onready var wander = $StateMachine/Wander

@export var speed: float = 150.0
@export var max_speed: float = 150.0
@export var acceleration: float = 75
@export var friction: float  = acceleration / speed
@onready var statemachine = $StateMachine
@onready var label = $Label
var alarmed: bool = false
var danger_element = null

func _physics_process(delta):
	label.text = str(statemachine.state.name)
func _on_detection_area_body_entered(body):
	if body is Player:
		alarmed = true
		danger_element = body as Player
		print(danger_element)

func _on_detection_area_body_exited(body):
	if body is Player:
		await get_tree().create_timer(3).timeout
		alarmed = false
		danger_element = null

