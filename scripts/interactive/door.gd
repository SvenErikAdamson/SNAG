extends StaticBody2D

@onready var  animation_player: AnimationPlayer = $AnimationPlayer
# Called when the node enters the scene tree for the first time.
func _ready():
	animation_player.play("Closed")
	pass # Replace with function body.



	
func close():
	animation_player.play("Closed")

func _on_area_2d_body_entered(body):
	if body is Player:
		SoundManager.play_sound(SoundManager.DOOR)
		animation_player.play("Opening")
	pass # Replace with function body.


func _on_area_2d_body_exited(body):
	if body is Player:
		SoundManager.play_sound(SoundManager.DOOR)
		animation_player.play("Closing")
	pass # Replace with function body.
