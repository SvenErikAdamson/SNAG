extends PlayerState

@export var _animated_sprite: NodePath
@onready var animated_sprite: AnimatedSprite2D = get_node(_animated_sprite)

func enter(_msg := {}) -> void:
	animated_sprite.play("Idle")
	owner.velocity = Vector2.ZERO

func physics_update(delta: float) -> void:
	player.velocity.x = lerp(player.velocity.x, player.friction * delta, 0)
	player.move_and_slide()

	if player.get_input_direction() != Vector2.ZERO:
		state_machine.transition_to("Walk")
