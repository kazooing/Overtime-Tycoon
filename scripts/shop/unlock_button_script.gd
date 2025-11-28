extends TextureButton

var task_id
var task_price
var target
signal change_to_upgrade(id:int, status:int)

func _on_ui_layer_give_to_unlock_button_task(price: int, id: int, orgin_parent: Node) -> void:
	task_price = price
	task_id = id
	target = orgin_parent


func _on_pressed() -> void:
	print(GM.curMoney)
	print(task_price)
	print(task_id)
	if GM.curMoney >= task_price && GM.tasks[task_id]["owned"] == false:
		if task_id == 3:
			get_tree().change_scene_to_file("res://scenes/ending_scene_sad.tscn")
			return
		GM.tasks[task_id]["index"] += 1
		GM.tasks[task_id]["owned"] = true
		GM.curMoney -= task_price
		change_to_upgrade.emit(task_id, GM.tasks[task_id]["index"])
		#$"../../shop_tab/tasks/slot1/item_status"
		print("../../UILayer/shop_tab/tasks/slot" + str(task_id) + "/item_status")
		#var item_status = get_node("/root/UpgradeShop/UILayer/shop_tab/tasks/slot" + str(task_id) + "/item_status")
		var item_status = target.get_node("item_status")
		item_status.texture = load("res://sprites1/upgrade_shop/upgrade default.png")
		var item_status_clicked = target.get_node("item_status_clicked")
		item_status_clicked.texture = load("res://sprites1/upgrade_shop/upgrade when click.png")
		$"../../../AudioStreamPlayer".play()
		get_parent().get_parent().close_inspector_task()
