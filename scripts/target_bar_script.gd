extends TextureProgressBar


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if GM.restart == 1:
		GM.weekly_target = 50
		GM.curMoney = 0
		print("HSOS")
	else:
		print("FFS")
	GM.max_value = GM.weekly_target*(GM.weekly_mult**(GM.week_count-1))
	print("This is weekly target ",  GM.max_value)
	print("This is current money", GM.curMoney)
	value = GM.curMoney
	print("This is money value ", value)
