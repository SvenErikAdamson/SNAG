extends WorkShop


func _process(_delta):
	focus_workshop()
	player_interaction()


func _on_interaction_area_body_entered(body):
	if body is Player:
		relevant_person = body as Player
	
func _on_interaction_area_body_exited(body):
	if body is Player:
		relevant_person = null


func player_interaction():
	if Input.is_action_just_pressed("interact"):
		Globals.in_control = false
		$Drone/Camera2D.enabled = true
		$Drone.drone_used = true
	if Input.is_action_just_pressed("escape"):
		Globals.in_control = true
		$Drone/Camera2D.enabled = false
		$Drone.drone_used = false
		
		
