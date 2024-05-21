class_name Player extends CharacterBody2D

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var item_carried_sprite: Sprite2D = $CarriedItemSprite

var speed: float = 150
var acceleration: float = 75
var friction: float = acceleration / speed

var last_direction: Vector2
func ready():
	set_velocity(Vector2.ZERO)

func _physics_process(delta):
		apply_friction(delta)

func get_input_direction() -> Vector2:
		var input_direction = Vector2(
			Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
			Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
		)
		if input_direction < Vector2.ZERO:
			$AnimatedSprite2D.flip_h = true

		if input_direction > Vector2.ZERO:
			$AnimatedSprite2D.flip_h = false
		last_direction = input_direction
		return input_direction

func apply_friction(delta: float):
	velocity -= velocity * friction * delta


