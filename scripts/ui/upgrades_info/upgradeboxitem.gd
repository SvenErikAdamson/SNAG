extends VBoxContainer


@onready var item_image: TextureRect = $TextureRect
@onready var  item_label: Label = $Label



func set_item_text(item_text):
	item_label.set_text(item_text)

func set_item_texture(texture: Texture):
	item_image.texture = texture
