extends Control



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GM.connect("continue_option", continue_option)
	GM.connect("ahhh", pls_work)
	if GM.main_menu_count == -1:
		get_node("/root/Game/WorkScene").visible = false
		get_node("/root/Game/WorkScene/Canvas").visible = false
		get_node("MainMenuBox/Continue").visible = false
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
	else:
		print("200")
		get_node("/root/Game/StartScreen").visible = false
		get_node("/root/Game/StartScreen/MainMenuBox").visible = false
		get_tree().paused = false 	
		
	GM.main_menu_count += 1

	
func pls_work() -> void:
	get_node("/root/Game/StartScreen").visible = true
	get_node("/root/Game/StartScreen/Background").visible = true
	get_node("/root/Game/StartScreen/MainMenuBox").visible = true

func _on_new_game_pressed() -> void:

	if GM.loop_count > 0 :
		print("5")
		GM.restart = 1
		get_node("/root/Game/StartScreen").visible = false
		get_tree().change_scene_to_file("res://scenes/game.tscn")
		GM.loop_count = 3
		

	elif GM.loop_count == 0:
		if ((GM.main_menu_count%2) == 1) and (GM.game_start_count == 0):
			get_node("/root/Game/StartScreen").visible = false
			get_node("/root/Game/WorkScene").visible = true
			get_node("/root/Game/WorkScene/Canvas").visible = true
			get_node("/root/Game/WorkScene/PauseLayer/PauseMenuInGame/Background").visible = false
			get_node("/root/Game/WorkScene/PauseLayer/PauseMenuInGame/PauseMenuBox").visible = false
			get_node("/root/Game/WorkScene/PauseLayer/PauseMenuInGame").visible = true
			get_node("/root/Game/WorkScene/PauseLayer/PauseMenuInGame/Pause").visible = true	
			get_node("/root/Game/StartScreen/MainMenuBox").visible = false
			get_tree().paused = false
			print("4")
		elif ((GM.main_menu_count%2) == 0) and (GM.game_start_count == 0) :
			get_node("/root/Game/StartScreen").visible = false
			get_tree().change_scene_to_file("res://scenes/game.tscn")
			GM.emit_signal("reset", 1)
			print("5")
		elif ((GM.main_menu_count%2) == 1) and (GM.game_start_count == 1):
			get_node("/root/Game/StartScreen").visible = false
			get_tree().change_scene_to_file("res://scenes/game.tscn")
			GM.emit_signal("reset", 1)
			print("7")	
		elif ((GM.main_menu_count%2) == 0) and (GM.game_start_count == 1):
			get_node("/root/Game/StartScreen").visible = false
			get_tree().change_scene_to_file("res://scenes/game.tscn")
			GM.emit_signal("reset", 1)
			print("7")
	GM.game_start_count = 1
	
func _on_continue_pressed() -> void:
	if GM.loop_count == 0:
		get_node("/root/Game/StartScreen").visible = false
		get_node("/root/Game/WorkScene").visible = true
		get_node("/root/Game/WorkScene/Canvas").visible = true
		get_node("/root/Game/WorkScene/PauseLayer/PauseMenuInGame").visible = true
		get_node("/root/Game/WorkScene/PauseLayer/PauseMenuInGame/Pause").visible = true	
		get_node("/root/Game/WorkScene/PauseLayer/PauseMenuInGame/Background").visible = false	
		get_node("/root/Game/WorkScene/PauseLayer/PauseMenuInGame/PauseMenuBox").visible = false	
		get_tree().paused = false

	elif GM.loop_count == 2:
		get_node("/root/Game/StartScreen").visible = false
		get_node("/root/Game/WorkScene").visible = true
		get_node("/root/Game/WorkScene/Canvas").visible = true
		get_node("/root/Game/WorkScene/PauseLayer/PauseMenuInGame").visible = true
		get_node("/root/Game/WorkScene/PauseLayer/PauseMenuInGame/Pause").visible = true	
		get_node("/root/Game/WorkScene/PauseLayer/PauseMenuInGame/Background").visible = false	
		get_node("/root/Game/WorkScene/PauseLayer/PauseMenuInGame/PauseMenuBox").visible = false	
		get_tree().paused = false
		GM.loop_count = 1
func _on_quit_pressed() -> void:
	get_tree().quit()
	
func continue_option() -> void:
	get_node("MainMenuBox/Continue").visible = true
