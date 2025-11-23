extends Label


func _onready() -> void:
	if GM.restart == 1:
		GM.curMoney = 0

func addMoney (amount):
	GM.curMoney += amount
	GM.money_gained_per_scene += amount
	fit_to_text_size()
	text = "$" + str(GM.money_gained_per_scene)

func fit_to_text_size():
	var current_money = GM.money_gained_per_scene
	if(current_money<100): add_theme_font_size_override("font_size", 30)
	elif(current_money >= 100 && current_money < 1000): add_theme_font_size_override("font_size", 29)
	elif(current_money > 1000 && current_money < 10000): add_theme_font_size_override("font_size", 24) 
	else: add_theme_font_size_override("font_size", 21)
	
