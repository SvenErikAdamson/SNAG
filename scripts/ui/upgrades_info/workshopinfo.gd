extends PanelContainer

@onready var upgrade_box_instance = load("res://scenes/ui/UpgradeBoxItem.tscn")
@onready var container: HBoxContainer = $VBoxContainer2/ReqContainer
@onready var name_label: Label = $VBoxContainer2/NameLabel
@onready var level_label : Label = $VBoxContainer2/LevelLabel




func _ready():
	owner.update_ui.connect(self._on_update)
	owner.level_up.connect(self._on_level_up)


func _on_level_up(name_m, levels):
	level_label.text = "Level " + str(levels) 
	name_label.text = name_m
	
func _on_update(upgrades_sent):
	owner.check_if_lvl()
	for child in container.get_children():
		child.queue_free()
	for item in upgrades_sent.keys():
			var text = upgrades_sent.get(item)
			var image = item.item_texture
			create_item_boxes(text, image)
			
			
			
func create_item_boxes(amount, image):
	var upgrade_box = upgrade_box_instance.instantiate()
	container.add_child(upgrade_box)
	var amount_text = amount
	upgrade_box.set_item_text(amount_text)
	upgrade_box.set_item_texture(image)


