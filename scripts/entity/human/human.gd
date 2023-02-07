extends Entity
class_name Human
@onready var wander = $StateMachine/Wander

@export var speed: float = 100.0
@export var max_speed: float = 150.0
@export var acceleration: float = 500.0
@export var friction: float  = 450

var alarmed: bool = false
var scared: bool = false

func _on_detection_area_body_entered(body):
	if body is Player:
		alarmed = true
	pass 

func _on_detection_area_body_exited(body):
	if body is Player:
		pass

