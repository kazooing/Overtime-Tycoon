extends TextureProgressBar


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if GM.restart == 1:
		GM.weekly_target = 50
		GM.curMoney = 0
	max_value = GM.weekly_target
	value = GM.curMoney
