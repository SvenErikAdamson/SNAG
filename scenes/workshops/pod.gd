extends WorkShop
@onready var animation_player: AnimatedSprite2D = $AnimatedSprite2D

func _process(_delta):
	focus_workshop()
	player_interaction()
		
func _on_interaction_area_body_entered(body):
	if body is Player:
		relevant_person = body as Player
	


func _on_interaction_area_body_exited(body):
	if body is Player:
		relevant_person = null




func _on_mouse_entered():
	$WorkShopInfo.show()


func _on_mouse_exited():
	$WorkShopInfo.hide()
