extends TextureButton

@export var decor_name: String
@export var decor_description: String
@export var decor_price: int
var decor_id

func _pressed() -> void:
	decor_id = str(name)
	get_parent().get_parent().get_parent().open_inspector(decor_name, decor_description, decor_price, decor_id)
