extends CanvasLayer


func _ready() -> void:
	var tween = get_tree().create_tween()
	tween.tween_property(self, "offset:x", 0, 1).set_trans(Tween.TRANS_SINE)
	

# function for DECORS

@onready var dimmer = $back_dimmer
@onready var inspector = $inspector_panel
@onready var buy_button = $inspector_panel/buy_button
@onready var decor_icon = $inspector_panel/icon
@onready var decor_price = $inspector_panel/price

signal tween_dimmer_fade_in
signal tween_dimmer_fade_out
signal give_to_buy_button(price: int, id: String)

func open_inspector(title:String, desc:String, price:int, id:String):
	tween_dimmer_fade_in.emit()
	give_to_buy_button.emit(price, id)
	decor_icon.texture = load(GM.pajangan[int(id)]["icon"])
	$inspector_panel/title.text = title
	$inspector_panel/description.text = desc
	dimmer.visible = true
	decor_price.text = "$ " + str(price)
	#show dimmer 
	var tween = get_tree().create_tween()
	tween.tween_property(inspector, "position:x", 880, 0.3).set_trans(Tween.TRANS_SINE)

func _on_tween_dimmer_fade_in() -> void:
	var tween = get_tree().create_tween()
	tween.tween_property(dimmer, "color:a", 0.5, 0.3).set_trans(Tween.TRANS_SINE)

# when clicked outside inspector 
func _on_back_dimmer_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed:
		close_inspector()
		
func close_inspector():
	tween_dimmer_fade_out.emit()
	var tween = get_tree().create_tween()
	tween.tween_property(inspector, "position:x", 1280, 0.3)

func _on_tween_dimmer_fade_out() -> void:
	var tween = get_tree().create_tween()
	tween.tween_property(dimmer, "color:a", 0, 0.3).set_trans(Tween.TRANS_SINE)
	dimmer.visible = false
	
	
# fucntion for TASKS
	
@onready var dimmer_task = $back_dimmer_task
@onready var inspector_task = $inspector_panel_task
@onready var unlock_button = $inspector_panel_task/unlock_button
@onready var upgrade_button = $inspector_panel_task/upgrade_button
@onready var task_icon = $inspector_panel_task/icon
@onready var task_price = $inspector_panel_task/price
@onready var note_price = $inspector_panel_task/above_price

signal tween_dimmer_task_fade_in
signal tween_dimmer_task_fade_out
signal give_to_unlock_button_task(price: int, id: int)
signal give_to_upgrade_button_task(price: int, id: int)
#signal change_buy_button_based_on_unlock_upgrade(status:int)

func open_inspector_task(title:String, desc:String, id:int, status:int, orgin: Node):
	var current_price = 0
	#change_buy_button_based_on_unlock_upgrade.emit(id)
	var orgin_parent = orgin.get_parent()
	
	if status==-1:	#if haven't unlocked
		upgrade_button.disabled = true
		upgrade_button.visible = false
		unlock_button.disabled = false
		unlock_button.visible = true
		current_price = GM.tasks[id]["unlock_cost"]
		give_to_unlock_button_task.emit(current_price, id, orgin_parent)
		note_price.text = "Price to\nunlock:"
		close_inspector_task()
	else:	#if unlocked
		upgrade_button.disabled = false
		upgrade_button.visible = true
		unlock_button.disabled = true
		unlock_button.visible = false
		current_price = GM.tasks[id]["upgrade_cost"][status]
		give_to_upgrade_button_task.emit(current_price, id, orgin_parent)
		note_price.text = "Price to\nupgrade:"
	dimmer_task.visible = true
	tween_dimmer_task_fade_in.emit()
	task_icon.texture = load(GM.tasks[id]["icon"])
	$inspector_panel_task/title.text = title
	$inspector_panel_task/description.text = desc
	
	task_price.text = "$" + str(current_price)
	#show dimmer 
	var tween = get_tree().create_tween()
	tween.tween_property(inspector_task, "position:x", 880, 0.3).set_trans(Tween.TRANS_SINE)
	
	

func _on_tween_dimmer_task_fade_in() -> void:
	var tween = get_tree().create_tween()
	tween.tween_property(dimmer_task, "color:a", 0.5, 0.3).set_trans(Tween.TRANS_SINE)

# when clicked outside inspector 
func _on_back_dimmer_task_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed:
		close_inspector_task()
		
func close_inspector_task():
	tween_dimmer_task_fade_out.emit()
	var tween = get_tree().create_tween()
	tween.tween_property(inspector_task, "position:x", 1280, 0.3)

func _on_tween_dimmer_task_fade_out() -> void:
	var tween = get_tree().create_tween()
	tween.tween_property(dimmer_task, "color:a", 0, 0.3).set_trans(Tween.TRANS_SINE)
	dimmer_task.visible = false
	
	

func _on_texture_button_pressed() -> void:
	get_node("/root/UpgradeShop/PauseLayer").visible = false
	GM.loop_count = 1
	GM.day_count += 1
	GM.first_loop = 0
	print("This is day count ", + GM.day_count)
	if (GM.day_count%5) == 0:
		GM.week_count += 1
		print("This is week count ", + GM.week_count)
		GM.curMoney -= GM.max_value
		if GM.tasks[3]["owned"] == false and GM.week_count >= 4:
			get_tree().change_scene_to_file("res://scenes/ending_scene_good.tscn")
		else:
			if GM.curMoney < 0:
				get_tree().change_scene_to_file("res://scenes/game_over_scene.tscn")
			else:
				get_tree().change_scene_to_file("res://scenes/game.tscn")
	else:
		get_tree().change_scene_to_file("res://scenes/game.tscn")


	


func _on_unlock_button_change_to_upgrade(id: int, status: int) -> void:
	upgrade_button.disabled = false
	upgrade_button.visible = true
	unlock_button.disabled = true
	unlock_button.visible = false
	if status > 0:
		var current_price = GM.tasks[id]["upgrade_cost"][status]
		give_to_upgrade_button_task.emit(current_price, id)
		note_price.text = "Price to\nupgrade:"
		task_price.text = "$" + str(current_price)
	else:
		print("Bad ending")
		#get_tree().change_scene_to_file("res://scenes/ending_scene_sad.tscn")


func _on_upgrade_button_is_max_upgrade(id: int) -> void:
	var item_status = get_node("shop_tab/tasks/slot" + str(id) + "/item_status")
	var item_button = get_node("shop_tab/tasks/slot" + str(id) + "/" + str(id))
	item_button.disabled = true
	item_status.texture = load("res://sprites1/upgrade_shop/out of stock (use on top of the product).png")
