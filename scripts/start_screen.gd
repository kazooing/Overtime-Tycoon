extends Control



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GM.connect("continue_option", continue_option)
	GM.connect("ahhh", pls_work)
	
	if GM.main_menu_count == -1:
		get_node("/root/Game/WorkScene").visible = false
		get_node("/root/Game/WorkScene/ProgressLayer").visible = false
		get_node("MainMenuBox/Continue").visible = false
		get_node("MainMenuBox/ContinueClicked").visible = false
		get_node("/root/Game/WorkScene/PauseLayer/PauseMenuInGame").visible = false
		get_node("/root/Game/WorkScene/PauseLayer/PauseMenuInGame/Pause").visible = false
		get_tree().paused = true
	elif (GM.loop_count == 1) and ((GM.main_menu_count%2) == 1):
		get_node("/root/Game/CanvasLayer/StartScreen").visible = false
		get_node("/root/Game/CanvasLayer/StartScreen/MainMenuBox").visible = false
		get_tree().paused = false
	elif (GM.loop_count == 1) and ((GM.main_menu_count%2) == 0):
		get_node("/root/Game/CanvasLayer/StartScreen").visible = false
		get_node("/root/Game/CanvasLayer/StartScreen/MainMenuBox").visible = false
		get_tree().paused = false
	elif GM.loop_count == 2:
		get_node("MainMenuBox").visible = true
		get_node("Background").visible = true
		get_tree().paused = true
	elif GM.loop_count == 4:
		get_node("MainMenuBox").visible = true
		get_node("Background").visible = true
		get_node("/root/Game/WorkScene").visible = true
		get_node("/root/Game/WorkScene/ProgressLayer").visible = true
		get_node("/root/Game/WorkScene/PauseLayer/PauseMenuInGame").visible = true
		get_node("/root/Game/WorkScene/PauseLayer/PauseMenuInGame/Pause").visible = true
		get_node("MainMenuBox/ContinueClicked").visible = true
		get_node("MainMenuBox/Continue").visible = true
		get_tree().paused = true
	elif GM.loop_count == 5:
		get_node("MainMenuBox").visible = true
		get_node("Background").visible = true
		get_node("/root/Game/WorkScene").visible = true
		get_node("/root/Game/WorkScene/ProgressLayer").visible = true
		get_node("/root/Game/WorkScene/PauseLayer/PauseMenuInGame").visible = true
		get_node("/root/Game/WorkScene/PauseLayer/PauseMenuInGame/Pause").visible = true
		get_node("MainMenuBox/ContinueClicked").visible = true
		get_node("MainMenuBox/Continue").visible = true
		get_tree().paused = true
	else:
		get_node("/root/Game/CanvasLayer/StartScreen").visible = false
		get_node("/root/Game/CanvasLayer/StartScreen/MainMenuBox").visible = false
		get_tree().paused = false
	GM.main_menu_count += 1

		

	
func pls_work() -> void:
	get_node("/root/Game/CanvasLayer/StartScreen").visible = true
	get_node("/root/Game/CanvasLayer/StartScreen/Background").visible = true
	get_node("/root/Game/CanvasLayer/StartScreen/MainMenuBox").visible = true

		
func _on_new_game_pressed() -> void:
	get_node("MainMenuBox/NewGame").visible = false
	await get_tree().create_timer(0.1).timeout
	if (GM.loop_count > 0) or (GM.first_loop == 1) :
		GM.restart = 1
		for item in GM.pajangan:
			item["owned"] = false
		get_node("/root/Game/CanvasLayer/StartScreen/Background").visible = false
		get_node("/root/Game/CanvasLayer/StartScreen/MainMenuBox").visible = false
		get_tree().change_scene_to_file("res://scenes/game.tscn")
		GM.loop_count = 3
	elif GM.loop_count == 0:
		get_node("/root/Game/WorkScene").visible = true
		get_node("/root/Game/WorkScene/ProgressLayer").visible = true
		get_node("/root/Game/WorkScene/PauseLayer/PauseMenuInGame").visible = true
		get_node("/root/Game/WorkScene/PauseLayer/PauseMenuInGame/Pause").visible = true
		get_node("/root/Game/WorkScene/PauseLayer/PauseMenuInGame/Quit").visible = true
		get_node("/root/Game/WorkScene/PauseLayer/PauseMenuInGame/Background").visible = false
		get_node("/root/Game/CanvasLayer/StartScreen").visible = false
		get_node("/root/Game/CanvasLayer/StartScreen/MainMenuBox").visible = false
		get_tree().paused = false
		await get_tree().create_timer(0.5).timeout
		get_node("/root/Game/CanvasLayer/StartScreen/MainMenuBox/NewGame").visible = true
	GM.game_start_count = 1
	
func _on_continue_pressed() -> void:
	get_node("MainMenuBox/Continue").visible = false
	await get_tree().create_timer(0.1).timeout
	GM.emit_signal("work_quit")
	if GM.loop_count == 0:
		get_node("/root/Game/WorkScene").visible = true
		get_node("/root/Game/WorkScene/ProgressLayer").visible = true
		get_node("/root/Game/WorkScene/PauseLayer/PauseMenuInGame").visible = true
		get_node("/root/Game/WorkScene/PauseLayer/PauseMenuInGame/Pause").visible = true	
		get_node("/root/Game/WorkScene/PauseLayer/PauseMenuInGame/Quit").visible = true	
		get_node("/root/Game/WorkScene/PauseLayer/PauseMenuInGame/Background").visible = false	
		get_node("/root/Game/CanvasLayer/StartScreen").visible = false
		get_tree().paused = false

	elif GM.loop_count == 2:
		get_node("/root/Game/WorkScene").visible = true
		get_node("/root/Game/WorkScene/ProgressLayer").visible = true
		get_node("/root/Game/WorkScene/PauseLayer/PauseMenuInGame").visible = true
		get_node("/root/Game/WorkScene/PauseLayer/PauseMenuInGame/Pause").visible = true	
		get_node("/root/Game/WorkScene/PauseLayer/PauseMenuInGame/Quit").visible = true	
		get_node("/root/Game/WorkScene/PauseLayer/PauseMenuInGame/Background").visible = false	
		get_node("/root/Game/CanvasLayer/StartScreen").visible = false
		get_tree().paused = false
		GM.loop_count = 1
	
	elif GM.loop_count == 4:
		get_node("/root/Game/CanvasLayer/StartScreen").visible = false
		get_node("/root/Game/CanvasLayer/StartScreen/Background").visible = false
		get_node("/root/Game/CanvasLayer/StartScreen/MainMenuBox").visible = false
		get_tree().paused = false
		get_tree().change_scene_to_file("res://scenes/day_recap_scene.tscn")

	elif GM.loop_count == 5:
		get_node("/root/Game/CanvasLayer/StartScreen").visible = false
		get_node("/root/Game/CanvasLayer/StartScreen/Background").visible = false
		get_node("/root/Game/CanvasLayer/StartScreen/MainMenuBox").visible = false
		get_tree().paused = false
		get_tree().change_scene_to_file("res://scenes/upgrade_shop_scene.tscn")


		
func _on_quit_pressed() -> void:
	get_node("MainMenuBox/Quit").visible = false
	await get_tree().create_timer(0.1).timeout
	get_tree().quit()
	
func continue_option() -> void:
	get_node("MainMenuBox/Continue").visible = true
