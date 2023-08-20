extends PlayerState

@export var _animated_sprite: NodePath
@onready var animated_sprite: AnimatedSprite2D = get_node(_animated_sprite)


func enter(_msg := {}) -> void:
	animated_sprite.play("Walk")

func physics_update(delta:float) -> void:

	if player.timer.time_left <= 0:
		player.player_audio.pitch_scale = randf_range(0.8,1.2)
		player.player_audio.play()
		player.timer.start(0.3)
	Globals.energy -= delta
	if player.get_input_direction() != Vector2.ZERO:
		player.velocity = player.get_input_direction() * player.speed* delta * player.acceleration
		player.move_and_slide()
		
	elif player.get_input_direction().is_equal_approx(Vector2.ZERO):
		state_machine.transition_to("Idle")
