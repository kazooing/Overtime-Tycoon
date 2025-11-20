extends Node2D

var money_added_animation := preload("res://scenes/money_added.tscn")
var day_ended = false
var all_tasks_ended = false
var changing = false

func _ready() -> void:
	GM.calls_done_per_scene = 0
	GM.money_gained_per_scene = 0
	
	# check for items are bought
	for item in GM.pajangan:
		if item["owned"] == true:
			get_node("Pajangan/"+item["id"]).visible = true
			
	if GM.game_start_count > 0:
		get_node("PauseLayer/PauseMenuInGame").visible = true
		get_node("PauseLayer/PauseMenuInGame/Pause").visible = true
	
	if GM.loop_count == 1:
		get_node("/root/Game/WorkScene").visible = true
		get_node("/root/Game/WorkScene/ProgressLayer").visible = true
		get_node("/root/Game/WorkScene/PauseLayer/PauseMenuInGame").visible = true
		get_node("/root/Game/WorkScene/PauseLayer/PauseMenuInGame/Pause").visible = true	
		get_node("/root/Game/WorkScene/PauseLayer/PauseMenuInGame/Background").visible = false	
		get_node("/root/Game/WorkScene/PauseLayer/PauseMenuInGame/PauseMenuBox").visible = false	
	elif GM.loop_count == 2:
		get_node("/root/Game/WorkScene").visible = false
		get_node("/root/Game/WorkScene/ProgressLayer").visible = false
		get_node("/root/Game/WorkScene/PauseLayer/PauseMenuInGame").visible = false
		get_node("/root/Game/WorkScene/PauseLayer/PauseMenuInGame/Pause").visible = false	
	elif GM.loop_count == 4:
		get_node("/root/Game/WorkScene").visible = false
		get_node("/root/Game/WorkScene/ProgressLayer").visible = false
		get_node("/root/Game/WorkScene/PauseLayer/PauseMenuInGame").visible = false
		get_node("/root/Game/WorkScene/PauseLayer/PauseMenuInGame/Pause").visible = false	
	elif GM.loop_count == 5:
		get_node("/root/Game/WorkScene").visible = false
		get_node("/root/Game/WorkScene/ProgressLayer").visible = false
		get_node("/root/Game/WorkScene/PauseLayer/PauseMenuInGame").visible = false
		get_node("/root/Game/WorkScene/PauseLayer/PauseMenuInGame/Pause").visible = false
	

func play_added_money(amount_added: float, spawn_pos: Vector2) -> void:
	spawn_add_money(spawn_pos, amount_added) 


func spawn_add_money(pos: Vector2 , added):
	var moneyAdded = money_added_animation.instantiate()
	moneyAdded.position = pos
	moneyAdded.text = "+ $ " + str(added)
	
	add_child(moneyAdded)


func _on_work_timer_timeout() -> void:
	await get_tree().create_timer(0.5).timeout
	print("test")
	if all_tasks_ended and get_tree() != null:
		get_tree().change_scene_to_file("res://scenes/day_recap_scene.tscn")
	day_ended = true
	print("day_ended")

func confirm_tasks_ended(confirm : bool) -> void:
	all_tasks_ended = confirm
	await get_tree().create_timer(0.5).timeout
	print("test2")
	if all_tasks_ended and day_ended and get_tree() != null:
		get_tree().change_scene_to_file("res://scenes/day_recap_scene.tscn")
	print("all tasks finished", confirm)
