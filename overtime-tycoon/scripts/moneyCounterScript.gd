extends Label


func addMoney (amount):
	GM.curMoney += amount
	text = "Money:" + str(GM.curMoney)
