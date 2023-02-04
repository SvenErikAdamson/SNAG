extends PanelContainer

@onready var upgrade_box_instance = load("res://scenes/ui/UpgradeBoxItem.tscn")
@onready var container: HBoxContainer = $VBoxContainer2/ReqContainer
var parent


func _ready():
	owner.update_ui.connect(self._on_update)
	
	
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


