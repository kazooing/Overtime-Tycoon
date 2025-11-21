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
		get_node("/root/Game/StartScreen").visible = false
		get_node("/root/Game/StartScreen/MainMenuBox").visible = false
		get_tree().paused = false
	elif (GM.loop_count == 1) and ((GM.main_menu_count%2) == 0):
		get_node("/root/Game/StartScreen").visible = false
		get_node("/root/Game/StartScreen/MainMenuBox").visible = false
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
		get_node("/root/Game/StartScreen").visible = false
		get_node("/root/Game/StartScreen/MainMenuBox").visible = false
		get_tree().paused = false
	GM.main_menu_count += 1

		

	
func pls_work() -> void:
	get_node("/root/Game/StartScreen").visible = true
	get_node("/root/Game/StartScreen/Background").visible = true
	get_node("/root/Game/StartScreen/MainMenuBox").visible = true

		
func _on_new_game_pressed() -> void:
	get_node("MainMenuBox/NewGame").visible = false
	await get_tree().create_timer(0.1).timeout
	if (GM.loop_count > 0) or (GM.first_loop == 1) :
		GM.restart = 1
		get_node("/root/Game/WorkScene/Pajangan/#000").visible = false
		GM.pajangan_0 = 0
		GM.pajangan_exist_0 = 0
		get_node("/root/Game/WorkScene/Pajangan/#001").visible = false
		GM.pajangan_1 = 0
		GM.pajangan_exist_1 = 0
		get_node("/root/Game/WorkScene/Pajangan/#002").visible = false
		GM.pajangan_2 = 0
		GM.pajangan_exist_2 = 0
		get_node("/root/Game/StartScreen/Background").visible = false
		get_node("/root/Game/StartScreen/MainMenuBox").visible = false
		get_tree().change_scene_to_file("res://scenes/game.tscn")
		GM.loop_count = 3


	elif GM.loop_count == 0:
		if ((GM.main_menu_count%2) == 1) and (GM.game_start_count == 0):
			get_node("/root/Game/WorkScene").visible = true
			get_node("/root/Game/WorkScene/ProgressLayer").visible = true
			get_node("/root/Game/WorkScene/PauseLayer/PauseMenuInGame").visible = true
			get_node("/root/Game/WorkScene/PauseLayer/PauseMenuInGame/Pause").visible = true
			get_node("/root/Game/WorkScene/PauseLayer/PauseMenuInGame/Quit").visible = true
			get_node("/root/Game/WorkScene/PauseLayer/PauseMenuInGame/Background").visible = false
			get_node("/root/Game/StartScreen").visible = false
			get_node("/root/Game/StartScreen/MainMenuBox").visible = false
			get_tree().paused = false
			await get_tree().create_timer(0.5).timeout
			get_node("/root/Game/StartScreen/MainMenuBox/NewGame").visible = true
		elif ((GM.main_menu_count%2) == 0) and (GM.game_start_count == 0) :
			get_node("/root/Game/StartScreen").visible = false
			get_tree().change_scene_to_file("res://scenes/game.tscn")
			GM.emit_signal("reset", 1)
		elif ((GM.main_menu_count%2) == 1) and (GM.game_start_count == 1):
			get_node("/root/Game/StartScreen").visible = false
			get_tree().change_scene_to_file("res://scenes/game.tscn")
			GM.emit_signal("reset", 1)
		elif ((GM.main_menu_count%2) == 0) and (GM.game_start_count == 1):
			get_node("/root/Game/StartScreen").visible = false
			get_tree().change_scene_to_file("res://scenes/game.tscn")
			GM.emit_signal("reset", 1)
	GM.game_start_count = 1
	
func _on_continue_pressed() -> void:
	get_node("MainMenuBox/Continue").visible = false
	await get_tree().create_timer(0.1).timeout
	if GM.pajangan_0 == 2:
		GM.pajangan_0 = 1
	if GM.pajangan_1 == 2:
		GM.pajangan_1 = 1
	if GM.pajangan_2 == 2:
		GM.pajangan_2 = 1
	GM.emit_signal("work_quit")
	if GM.loop_count == 0:
		get_node("/root/Game/WorkScene").visible = true
		get_node("/root/Game/WorkScene/ProgressLayer").visible = true
		get_node("/root/Game/WorkScene/PauseLayer/PauseMenuInGame").visible = true
		get_node("/root/Game/WorkScene/PauseLayer/PauseMenuInGame/Pause").visible = true	
		get_node("/root/Game/WorkScene/PauseLayer/PauseMenuInGame/Quit").visible = true	
		get_node("/root/Game/WorkScene/PauseLayer/PauseMenuInGame/Background").visible = false	
		get_node("/root/Game/StartScreen").visible = false
		get_tree().paused = false

	elif GM.loop_count == 2:
		get_node("/root/Game/WorkScene").visible = true
		get_node("/root/Game/WorkScene/ProgressLayer").visible = true
		get_node("/root/Game/WorkScene/PauseLayer/PauseMenuInGame").visible = true
		get_node("/root/Game/WorkScene/PauseLayer/PauseMenuInGame/Pause").visible = true	
		get_node("/root/Game/WorkScene/PauseLayer/PauseMenuInGame/Quit").visible = true	
		get_node("/root/Game/WorkScene/PauseLayer/PauseMenuInGame/Background").visible = false	
		get_node("/root/Game/StartScreen").visible = false
		get_tree().paused = false
		GM.loop_count = 1
	
	elif GM.loop_count == 4:
		get_node("/root/Game/StartScreen").visible = false
		get_node("/root/Game/StartScreen/Background").visible = false
		get_node("/root/Game/StartScreen/MainMenuBox").visible = false
		get_tree().paused = false
		get_tree().change_scene_to_file("res://scenes/day_recap_scene.tscn")

	elif GM.loop_count == 5:
		get_node("/root/Game/StartScreen").visible = false
		get_node("/root/Game/StartScreen/Background").visible = false
		get_node("/root/Game/StartScreen/MainMenuBox").visible = false
		get_tree().paused = false
		get_tree().change_scene_to_file("res://scenes/upgrade_shop_scene.tscn")


		
func _on_quit_pressed() -> void:
	get_node("MainMenuBox/Quit").visible = false
	await get_tree().create_timer(0.1).timeout
	get_tree().quit()
	
func continue_option() -> void:
	get_node("MainMenuBox/Continue").visible = true
