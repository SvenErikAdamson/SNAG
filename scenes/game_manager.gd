extends Node2D
#TODO
#Spawn the actual ship
#check if docked or not
#something more
@export var space_ships = 5
@onready var docking_pnt = $DockingPoint
@onready var spawn_pnt = $SpawnPoint
@onready var ship_scene = preload("res://scenes/ship.tscn")

var is_docked: bool = false
var is_spawned: bool = false

func _ready():
	pass
func _process(_delta):
	if !is_spawned:
		spawn_ship()
		is_spawned = true

func spawn_ship():
	var ship = ship_scene.instantiate()
	add_child(ship)
	ship.position = spawn_pnt.position
	ship.destination = docking_pnt.global_position
	
