extends Area2D

func _ready() -> void:
	var button = get_node("Telephone/Area2D/Button")
	button.button_down.connect(on_press)
	button.button_up.connect(on_release)
	
	var telephone = get_node("Telephone/Area2D")
	telephone.area_entered.connect(phone_entry)

func on_press() -> void:
	$pickup_marker.visible = true

func on_release() -> void:
	$pickup_marker.visible = false

func phone_entry(area) -> void:
	if area == self:
		print("yeay")
