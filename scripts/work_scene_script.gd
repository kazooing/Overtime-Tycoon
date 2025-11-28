extends Node2D

signal disable_all_tasks
signal fail_all_tasks

var money_added_animation := preload("res://scenes/money_added.tscn")
var day_ended = false
var all_tasks_ended = false
var changing = false
@onready var sanity_bar = get_node("ProgressLayer/sanityBarUI")
@onready var calendar = $"ProgressLayer/calendar/day_counter"

func _ready() -> void:
	GM.calls_done_per_scene = 0
	GM.spreadsheets_done_per_scene = 0
	GM.meetings_done_per_scene = 0
	GM.money_gained_per_scene = 0
	GM.sanity_hits_zero_counter = 0
	sanity_bar.mult_decrease = 1
	sanity_bar.mult_increase = 1
	calendar.text = str(GM.day_count+1)
	
	
	# check for items are bought
	for item in GM.pajangan:
		if item["owned"] == true:
			get_node("Pajangan/"+item["id"]).visible = true
			sanity_bar.mult_increase+=item["recover_bonus"]
			sanity_bar.mult_decrease-=item["decrease_bonus"]
	if GM.tasks[2]["owned"]: $Webcam.visible = true
			
	#main menu from pause in various scene
	if GM.game_start_count > 0:
		get_node("PauseLayer/PauseMenuInGame").visible = true
		get_node("PauseLayer/PauseMenuInGame/Background").visible = false	
	if GM.loop_count == 1:
		get_node("/root/Game/WorkScene").visible = true
		get_node("/root/Game/WorkScene/ProgressLayer").visible = true
		get_node("/root/Game/WorkScene/PauseLayer/PauseMenuInGame").visible = true
		get_node("/root/Game/WorkScene/PauseLayer/PauseMenuInGame/Pause").visible = true	
		get_node("/root/Game/WorkScene/PauseLayer/PauseMenuInGame/Quit").visible = true	
		get_node("/root/Game/WorkScene/PauseLayer/PauseMenuInGame/Background").visible = false	
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
	if amount_added <= 0:
		return
	
	spawn_add_money(spawn_pos, amount_added) 

func play_lost_money(amount_lost: float, spawn_pos: Vector2):
	spawn_add_money(spawn_pos, amount_lost, "- $ ")

func spawn_add_money(pos: Vector2 , added: float, header = "+ $ "):
	var moneyAdded = money_added_animation.instantiate()
	moneyAdded.position = pos
	moneyAdded.text = header + str(added)
	
	if header == "- $ ":
		moneyAdded.modulate = Color.DARK_RED
	add_child(moneyAdded)


func _on_work_timer_timeout() -> void:
	get_node("PauseLayer").visible = false
	await get_tree().create_timer(0.5).timeout
	print("test")
	if all_tasks_ended and get_tree() != null:
		get_tree().change_scene_to_file("res://scenes/day_recap_scene.tscn")
	disable_all_tasks.emit()
	day_ended = true
	print("day_ended")

func confirm_tasks_ended(confirm : bool) -> void:
	all_tasks_ended = confirm
	await get_tree().create_timer(0.5).timeout
	print("test2")
	if all_tasks_ended and day_ended and get_tree() != null:
		get_tree().change_scene_to_file("res://scenes/day_recap_scene.tscn")
	print("all tasks finished", confirm)


func _on_sanity_bar_ui_sanity_bar_zero() -> void:
	$sanity_zeroed.play()
	GM.sanity_hits_zero_counter +=1
	# pass time for 1 hour, fill up the sanity bar by 50, any task that are currently running gets canceled
	
	#pass time for 1 hour
	var clock_sprite = get_node("ProgressLayer/Clock")
	var work_timer = get_node("work_timer")
	var remaining = work_timer.time_left
	if remaining > 16: clock_sprite.advance_time()
	var remaining_new = max(remaining-16, 0.001)
	work_timer.stop()
	work_timer.start(remaining_new)
	
	#fill up sanity bar
	sanity_bar.value = 50
	
	#cancel all tasks
	fail_all_tasks.emit()
