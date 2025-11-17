extends Label

func _onready() -> void:
	if GM.restart == 1:
		GM.curMoney = 0

func addMoney (amount):
	GM.curMoney += amount
	GM.money_gained_per_scene += amount
	text = ": $" + str(GM.money_gained_per_scene)
