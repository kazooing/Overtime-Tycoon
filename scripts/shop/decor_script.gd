extends TextureButton

@export var decor_name: String
@export var decor_description: String
@export var decor_price: int
var decor_id

func _ready() -> void:
	decor_id = str(name)
	var int_cur_id = int(decor_id)
	if GM.pajangan[int_cur_id]["owned"] == true:
		get_node("/root/UpgradeShop/UILayer/decor/slot"+decor_id+"/"+decor_id+"").disabled = true
	elif GM.pajangan[int_cur_id]["owned"] == false:
		get_node("/root/UpgradeShop/UILayer/decor/slot"+decor_id+"/"+decor_id+"").disabled = false

func _pressed() -> void:
	decor_id = str(name)
	get_parent().get_parent().get_parent().open_inspector(decor_name, decor_description, decor_price, decor_id)

func _on_buy_button_give_to_decor_button() -> void:
	decor_id = str(name)
	var int_cur_id = int(decor_id)
	if GM.pajangan[int_cur_id]["owned"] == true:
		get_node("/root/UpgradeShop/UILayer/decor/slot"+decor_id+"/"+decor_id+"").disabled = true
	elif GM.pajangan[int_cur_id]["owned"] == false:
		get_node("/root/UpgradeShop/UILayer/decor/slot"+decor_id+"/"+decor_id+"").disabled = false
