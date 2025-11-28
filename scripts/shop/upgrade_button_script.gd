extends TextureButton

var task_price
var task_id
var target
@onready var price_label = get_parent().get_node("price")
@onready var above_price_label = get_parent().get_node("above_price")
signal is_max_upgrade(id: int)

func _on_ui_layer_give_to_upgrade_button_task(price: int, id: int, origin_parent) -> void:
	print(price, id, origin_parent)
	task_price = price
	task_id = id
	target = origin_parent

func _on_pressed() -> void:
	print(task_id)
	if GM.curMoney >= GM.tasks[task_id]["upgrade_cost"][GM.tasks[task_id]["index"]]:
		GM.curMoney -= GM.tasks[task_id]["upgrade_cost"][GM.tasks[task_id]["index"]]
		GM.tasks[task_id]["index"] += 1
		if GM.tasks[task_id]["index"] == 4:	#apabila sudah max level
			disabled = true
			is_max_upgrade.emit(task_id)
			above_price_label.text = "Max\nUpgrade"
		else:	
			var upgrade_cost = GM.tasks[task_id]["upgrade_cost"][GM.tasks[task_id]["index"]]
			price_label.text = "$" + str(upgrade_cost)
			var value_to_change = GM.tasks[task_id]["upgrade_value"][GM.tasks[task_id]["index"]]
			if task_id==0: # if task is telephone
				GM.add_money_telephone = value_to_change
			elif task_id==1:	# if task is spreadsheet
				GM.add_money_spreadsheet = value_to_change
			elif task_id==2: #if task meeting
				GM.add_money_meeting = value_to_change
		$"../../../AudioStreamPlayer".play()
