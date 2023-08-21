extends Node2D
#TODO
#Spawn the actual ship
#check if docked or not
#something more
@export var space_ships = 5

var is_docked: bool = false
var is_spawned: bool = false

func _ready():
	pass
func _process(delta):
	if !is_spawned:
		send_ship()
		is_spawned = false

func send_ship():
	pass
