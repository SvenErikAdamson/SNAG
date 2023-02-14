extends WorkShop
@onready var animation_player: AnimatedSprite2D = $AnimatedSprite2D

func _process(delta):
	focus_workshop()
	player_interaction()
	Globals.base_energy -= delta * 0.1

func player_interaction():
	if Input.is_action_just_pressed("interact") and relevant_person != null and can_interact(relevant_person.item_carried) and relevant_person.item_carried != null:
		var type = check_interaction_type(relevant_person.item_carried)
		match type:
			1: 
				relevant_person.item_into_machine()
				Globals.base_energy += 10
			2:
				var can_upgrade = upgrade_check(relevant_person.item_carried)
				if can_upgrade:
					SoundManager.play_sound(SoundManager.TILL)
					relevant_person.item_into_machine()
					update_ui.emit(upgrades[level])
			3: 
				print("Something is wrong")
				
func _on_interaction_area_body_entered(body):
	if body is Player:
		relevant_person = body as Player
	
func _on_interaction_area_body_exited(body):
	if body is Player:
		relevant_person = null
