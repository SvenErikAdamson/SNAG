extends CanvasLayer




# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	$GUI/EnergyBar.value = Globals.energy
	$GUI/MainFrameBar.value = Globals.base_energy
	pass
