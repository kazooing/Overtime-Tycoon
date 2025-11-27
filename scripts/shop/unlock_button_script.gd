extends TextureButton

var task_id
var task_price
signal change_to_upgrade(id:int, status:int)

func _on_ui_layer_give_to_unlock_button_task(price: int, id: int) -> void:
	task_price = price
	task_id = id


func _on_pressed() -> void:
	if GM.curMoney >= task_price && GM.tasks[task_id]["owned"] == false:
		GM.tasks[task_id]["index"] += 1
		GM.tasks[task_id]["owned"] = true
		GM.curMoney -= task_price
		change_to_upgrade.emit(task_id, GM.tasks[task_id]["index"])
		var item_status = get_node("/root/UpgradeShop/UILayer/shop_tab/tasks/slot" + str(task_id) + "/item_status")
		item_status.texture = load("res://sprites1/upgrade_shop/upgrade default.png")
		var item_status_clicked = get_node("/root/UpgradeShop/UILayer/shop_tab/tasks/slot" + str(task_id) + "/item_status_clicked")
		item_status_clicked.texture = load("res://sprites1/upgrade_shop/upgrade when click.png")
		$"../../../AudioStreamPlayer".play()
