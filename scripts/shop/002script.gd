extends Node2D


func _on_buy_button_pressed() -> void:
	if GM.curMoney>=GM.pajangan[2]["price"]:
		GM.pajangan_2 = 1
		GM.pajangan_exist_2 = 1
		GM.pajangan[2]["owned"] = true
		GM.curMoney -= GM.pajangan[2]["price"]
