extends WorkShop
@onready var animation_player: AnimatedSprite2D = $AnimatedSprite2D


func _ready():
	pass # Replace with function body.

func _physics_process(_delta):
	if Input.is_action_just_pressed("interact") and !full and !in_progress and relevant_person != null and input_required:
		if relevant_person.item_carried == takes:
			relevant_person.item_into_machine()
			start_production()
		else:
			pass

		
		
func _on_interaction_area_body_entered(body):
	if body is Player:
		relevant_person = body as Player
	


func _on_interaction_area_body_exited(body):
	if body is Player:
		relevant_person = null


