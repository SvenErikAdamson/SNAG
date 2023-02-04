extends WorkShop
@onready var animation_player: AnimatedSprite2D = $AnimatedSprite2D


func _ready():
	start_production_cycle()

func _process(_delta):
	focus_workshop()
	if Input.is_action_just_pressed("interact"):
		## if the player has a item that's required for the upgrade:
		## 1) look through our required items for upgrade
		## if the player has a item that can be put into the machine:
		pass

#	if Input.is_action_just_pressed("interact") and !is_full and !in_progress and relevant_person != null and input_required:
#		if relevant_person.item_carried == takes:
#			relevant_person.item_into_machine()
#			start_production_cycle()
		
		
func _on_interaction_area_body_entered(body):
	if body is Player:
		relevant_person = body as Player
	


func _on_interaction_area_body_exited(body):
	if body is Player:
		relevant_person = null

