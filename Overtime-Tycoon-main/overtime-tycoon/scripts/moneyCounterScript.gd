extends Label


func addMoney (amount):
	GM.curMoney += amount
	GM.money_gained_per_scene += amount
	text = "Money:" + str(GM.curMoney)
