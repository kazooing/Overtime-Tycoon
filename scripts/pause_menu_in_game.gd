extends Control

func _on_ready() -> void:
	get_node("/root/Game/WorkScene/PauseLayer/PauseMenuInGame").visible = true


	
func _on_pause_pressed() -> void:
	get_node("Pause").visible = false
	await get_tree().create_timer(0.1).timeout
	if GM.pause_resume_count == 0:
		get_node("Pause").visible = true
		get_node("Background").visible = true
		GM.pause_resume_count = 1
		get_tree().paused = true
	elif GM.pause_resume_count == 1: 
		get_node("Pause").visible = true
		get_node("Background").visible = false
		get_tree().paused = false
		GM.pause_resume_count = 0

	
func _on_quit_pressed() -> void:
	get_node("Quit").visible = false
	await get_tree().create_timer(0.1).timeout
	get_tree().paused = true
	GM.game_start_count = 0
	GM.main_menu_count += 1


	if GM.loop_count > 0:
		GM.game_start_count = 1
		GM.first_loop = 0
	elif GM.loop_count == 0:
		GM.first_loop = 1
	if ((GM.main_menu_count%2) == 1) and (GM.game_start_count == 0):
		get_node("/root/Game/WorkScene/PauseLayer/PauseMenuInGame").visible = false
		get_node("/root/Game/WorkScene/PauseLayer/PauseMenuInGame/Quit").visible = false	
		get_node("/root/Game/WorkScene").visible = false
		get_node("/root/Game/WorkScene/ProgressLayer").visible = false
		get_node("/root/Game/CanvasLayer/StartScreen").visible = true
		get_node("/root/Game/CanvasLayer/StartScreen/MainMenuBox").visible = true
		get_tree().paused = true
		GM.pause_resume_count = 0
		get_node("/root/Game/WorkScene/PauseLayer/PauseMenuInGame").visible = false

	elif ((GM.main_menu_count%2) == 0) and (GM.game_start_count == 0):
		get_node("/root/Game/WorkScene/PauseLayer/PauseMenuInGame").visible = false
		get_node("/root/Game/WorkScene/PauseLayer/PauseMenuInGame/Quit").visible = false
		get_node("/root/Game/WorkScene").visible = false
		get_node("/root/Game/WorkScene/ProgressLayer").visible = false
		get_node("/root/Game/CanvasLayer/StartScreen").visible = true
		get_node("/root/Game/CanvasLayer/StartScreen/MainMenuBox").visible = true
		get_tree().paused = true
		GM.pause_resume_count = 0
		get_node("/root/Game/WorkScene/PauseLayer/PauseMenuInGame").visible = false

	elif ((GM.main_menu_count%2) == 1) and (GM.game_start_count == 1):
		get_node("/root/Game/WorkScene/PauseLayer/PauseMenuInGame").visible = false
		get_node("/root/Game/WorkScene/PauseLayer/PauseMenuInGame/Quit").visible = false
		get_node("/root/Game/WorkScene").visible = false
		get_node("/root/Game/WorkScene/ProgressLayer").visible = false
		get_tree().paused = true	 
		GM.loop_count = 2
		GM.emit_signal("ahhh")
		GM.pause_resume_count = 0
		get_node("/root/Game/WorkScene/PauseLayer/PauseMenuInGame").visible = false

	elif ((GM.main_menu_count%2) == 0) and (GM.game_start_count == 1):
		get_node("/root/Game/WorkScene/PauseLayer/PauseMenuInGame").visible = false
		get_node("/root/Game/WorkScene/PauseLayer/PauseMenuInGame/Quit").visible = false
		get_node("/root/Game/WorkScene").visible = false
		get_node("/root/Game/WorkScene/ProgressLayer").visible = false
		get_tree().paused = true	
		GM.loop_count = 2
		GM.emit_signal("ahhh")
		GM.pause_resume_count = 0
		get_node("/root/Game/WorkScene/PauseLayer/PauseMenuInGame").visible = false

	if GM.main_menu_count > 0:
		GM.emit_signal("continue_option")
		GM.pause_resume_count = 0
		get_node("/root/Game/WorkScene/PauseLayer/PauseMenuInGame").visible = false
