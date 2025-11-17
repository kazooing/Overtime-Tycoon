extends Node2D


func _on_buy_button_pressed() -> void:
	if GM.curMoney>=GM.pajangan[1]["price"]:
		GM.pajangan[1]["owned"] = true
		GM.curMoney -= GM.pajangan[1]["price"]
