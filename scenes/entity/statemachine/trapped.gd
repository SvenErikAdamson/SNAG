extends State

@onready var human = owner as Human

func enter(_msg := {}) -> void:
	human.speed = 0
	human.velocity = Vector2.ZERO

func _physics_process(delta):
	human.velocity = Vector2.ZERO
