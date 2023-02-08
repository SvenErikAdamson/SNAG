extends Sprite2D
#This all should go to the shooting state probably or something like that, just takes the weapon data for how the shot should be done

@onready var net = preload("res://scenes/item/projectiles/Net.tscn")
@export var fire_rate: int = 5
@onready var timer = $Timer
var can_fire: bool = true

func _physics_process(_delta):
	look_at(get_global_mouse_position())
	
	if Input.is_action_just_pressed("shoot") and can_fire:
		timer.start()
		var net_instance = net.instantiate()
		net_instance.rotation = rotation
		net_instance.position = $Marker2D.position
		get_parent().add_child(net_instance)
		can_fire = false



func _on_timer_timeout():
	can_fire = true

