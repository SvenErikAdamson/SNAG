extends Entity
class_name Human

@export var speed: float = 150.0
@export var acceleration: float = 75
@export var friction: float  = acceleration / speed
@export var item_scene: PackedScene
@export var human_item: Resource

@onready var wander = $StateMachine/Wander
@onready var statemachine = $StateMachine
@onready var label: Label = $Label
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite: Sprite2D = $Sprite2D

var trapped: bool = false
var alarmed: bool = false
var danger_element = null

func _physics_process(_delta):
	label.text = str(statemachine.state.name)
	
func _on_detection_area_body_entered(body):
	if body is Player:
		alarmed = true
		danger_element = body as Player

func _on_detection_area_body_exited(body):
	if body is Player:
		await get_tree().create_timer(3).timeout
		alarmed = false
		danger_element = null

func _on_hit_box_area_entered(area):
	if area is Projectile:
		trapped = true
		
## Gotta fix this, error my life away, thread?
func create_human_item():
	var human = item_scene.instantiate()
	human.item = human_item
	human.global_position = global_position
	get_parent().add_child(human)
	queue_free()
	
func _on_hit_box_body_entered(body):
	if body is Player and trapped:
		create_human_item()

