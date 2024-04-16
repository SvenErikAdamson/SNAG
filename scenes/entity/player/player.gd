class_name Player extends CharacterBody2D

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var item_carried_sprite: Sprite2D = $CarriedItemSprite

var speed: float = 150
var acceleration: float = 75
var friction: float = acceleration / speed

var items_around_player: Array[Item] = []
var item_focused: Item = null
var item_carried: PackedScene = null

var last_direction: Vector2
func ready():
	set_velocity(Vector2.ZERO)

func _physics_process(delta):
		apply_friction(delta)

func get_input_direction() -> Vector2:
		var input_direction = Vector2(
			Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
			Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
		)
		if input_direction < Vector2.ZERO:
			$AnimatedSprite2D.flip_h = true

		if input_direction > Vector2.ZERO:
			$AnimatedSprite2D.flip_h = false
		last_direction = input_direction
		return input_direction

func apply_friction(delta: float):
	velocity -= velocity * friction * delta

func _on_item_detection_area_body_entered(body: Node2D) -> void:
	if body is Item:
		if item_focused != null:
			item_focused.modulate = ("ffffff")
		item_focused = body as Item
		item_focused.modulate = Color("60dd3c")
		items_around_player.append(body)

		
func _on_item_detection_area_body_exited(body: Node2D) -> void:
	if body is Item:
		body.modulate = ("ffffff")
		items_around_player.erase(body)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact") and item_focused != null:
		item_carried = item_focused.item_instance
		item_carried_sprite.show()
		item_carried_sprite.texture = item_focused.sprite.texture
		item_focused.queue_free()
		item_focused = null
		
	elif event.is_action_pressed("interact") and item_focused == null and item_carried != null:
		var item_instance = item_carried.instantiate() as Item
		$"../Items".add_child(item_instance)
		item_instance.global_position = global_position + get_input_direction()
		item_carried_sprite.hide()
		item_carried = null
		
