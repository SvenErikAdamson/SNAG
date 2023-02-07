class_name State
extends Node


var state_machine = null



func handle_input(_event: InputEvent) -> void:
	pass



func update(_delta: float) -> void:
	pass

func get_random_state(state_list: Array):
	state_list.shuffle()
	return state_list.pop_front()

func physics_update(_delta: float) -> void:
	pass




func enter(_msg := {}) -> void:
	pass




func exit() -> void:
	pass

