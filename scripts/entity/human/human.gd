extends Entity
class_name Human
@onready var wander = $StateMachine/Wander

@export var speed: float = 100.0
@export var max_speed: float = 150.0
@export var acceleration: float = 500.0
@export var friction: float  = 450
