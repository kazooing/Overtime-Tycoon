extends Control
	
func _on_pause_pressed() -> void:
	get_node("Background").visible = true
	get_node("PauseMenuBox").visible = true
	get_tree().paused = true
	
func _on_resume_pressed() -> void:
	get_node("Background").visible = false
	get_node("PauseMenuBox").visible = false
	get_tree().paused = false
	
func _on_quit_pressed() -> void:
	get_tree().quit()


func _on_main_menu_pressed() -> void:
	GM.game_start_count = 0
	GM.main_menu_count += 1
	if GM.loop_count > 0:
		GM.game_start_count = 1
	if ((GM.main_menu_count%2) == 1) and (GM.game_start_count == 0):
		get_node("/root/Game/WorkScene/PauseLayer/PauseMenuInGame").visible = false
		get_node("/root/Game/WorkScene/PauseLayer/PauseMenuInGame/Pause").visible = false	
		get_node("/root/Game/WorkScene").visible = false
		get_node("/root/Game/WorkScene/ProgressLayer").visible = false
		get_node("/root/Game/StartScreen").visible = true
		get_node("/root/Game/StartScreen/MainMenuBox").visible = true
		get_tree().paused = true
	elif ((GM.main_menu_count%2) == 0) and (GM.game_start_count == 0):
		get_node("/root/Game/WorkScene/PauseLayer/PauseMenuInGame").visible = false
		get_node("/root/Game/WorkScene/PauseLayer/PauseMenuInGame/Pause").visible = false
		get_node("/root/Game/WorkScene").visible = false
		get_node("/root/Game/WorkScene/ProgressLayer").visible = false
		get_node("/root/Game/StartScreen").visible = true
		get_node("/root/Game/StartScreen/MainMenuBox").visible = true
		get_tree().paused = true
	elif ((GM.main_menu_count%2) == 1) and (GM.game_start_count == 1):
		get_node("/root/Game/WorkScene/PauseLayer/PauseMenuInGame").visible = false
		get_node("/root/Game/WorkScene/PauseLayer/PauseMenuInGame/Pause").visible = false
		get_node("/root/Game/WorkScene").visible = false
		get_node("/root/Game/WorkScene/ProgressLayer").visible = false
		get_tree().paused = true	 
		GM.loop_count = 2
		GM.emit_signal("ahhh")
	elif ((GM.main_menu_count%2) == 0) and (GM.game_start_count == 1):
		get_node("/root/Game/WorkScene/PauseLayer/PauseMenuInGame").visible = false
		get_node("/root/Game/WorkScene/PauseLayer/PauseMenuInGame/Pause").visible = false
		get_node("/root/Game/WorkScene").visible = false
		get_node("/root/Game/WorkScene/ProgressLayer").visible = false
		get_tree().paused = true	
		GM.loop_count = 2
		GM.emit_signal("ahhh")
	
	


	if GM.main_menu_count > 0:
		GM.emit_signal("continue_option")
