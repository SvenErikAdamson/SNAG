extends PanelContainer

@onready var upgrade_box_instance = load("res://scenes/ui/UpgradeBoxItem.tscn")
@onready var container: HBoxContainer = $VBoxContainer2/ReqContainer
var parent

signal update_ui(on_update)
func _ready():
	pass
	
	
func create_item_boxes(amount, image):
	var upgrade_box = upgrade_box_instance.instantiate()
	container.add_child(upgrade_box)
	var amount_text = amount
	upgrade_box.set_item_text(amount_text)
	upgrade_box.set_item_texture(image)

func _on_update():
	print("yolo")
