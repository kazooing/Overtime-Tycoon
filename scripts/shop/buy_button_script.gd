extends TextureButton

var cur_price: int
var cur_id: String
signal give_to_decor_button

func _on_ui_layer_give_to_buy_button(price: int, id: String) -> void:
	cur_price = price
	cur_id = id
	
func _on_pressed() -> void:
	var int_cur_id = int(cur_id)
	if(cur_price<=GM.curMoney && GM.pajangan[int_cur_id]["owned"]==false):
		GM.pajangan[int_cur_id]["owned"] = true
		GM.curMoney -= cur_price
		give_to_decor_button.emit()
		$"../../../AudioStreamPlayer".play()
