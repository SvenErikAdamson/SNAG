extends WorkShop
@onready var animation_player: AnimatedSprite2D = $AnimatedSprite2D


func _ready():
	randomize()
	
		
func _process(_delta):
	if Input.is_action_just_pressed("ui_accept"):
		print( choose_random_item())
		
		
func _on_interaction_area_body_entered(body):
	if body is Player:
		relevant_person = body as Player
	


func _on_interaction_area_body_exited(body):
	if body is Player:
		relevant_person = null


