extends TextureProgressBar


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	max_value = GM.weekly_target
	value = GM.curMoney
