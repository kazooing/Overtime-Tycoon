extends Node2D


func _on_buy_button_pressed() -> void:
	if GM.curMoney>=GM.pajangan[0]["price"] && GM.pajangan[0]["owned"]==false:
		GM.pajangan[0]["owned"] = true
		GM.curMoney -= GM.pajangan[0]["price"]
