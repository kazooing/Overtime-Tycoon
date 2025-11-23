extends Control
	
func _ready() -> void:
	if GM.loop_count == 5:
		get_node("/root/UpgradeShop/UILayer").visible = true
	if GM.pause_resume_count == 2:
		get_node("/root/UpgradeShop/PauseLayer/PauseMenuUpgradeShop").visible = true
	GM.pause_resume_count = 0
	
func _on_pause_pressed() -> void:
	get_node("Pause").visible = false
	await get_tree().create_timer(0.1).timeout
	if GM.pause_resume_count == 0:
		get_node("/root/UpgradeShop/PauseLayer/PauseMenuUpgradeShop/Pause").visible = true
		get_node("/root/UpgradeShop/PauseLayer/PauseMenuUpgradeShop/Background").visible = true
		GM.pause_resume_count = 1
		get_tree().paused = true
	elif GM.pause_resume_count == 1: 
		get_node("/root/UpgradeShop/PauseLayer/PauseMenuUpgradeShop/Pause").visible = true
		get_node("/root/UpgradeShop/PauseLayer/PauseMenuUpgradeShop/Background").visible = false
		GM.pause_resume_count = 0
		get_tree().paused = false
		
func _on_quit_pressed() -> void:
	GM.restart = 0
	get_node("Quit").visible = false
	await get_tree().create_timer(0.1).timeout
	get_node("/root/UpgradeShop/PauseLayer/PauseMenuUpgradeShop").visible = true
	get_tree().paused = true
	GM.game_start_count = 0
	GM.main_menu_count += 1
	
	if GM.loop_count > 0:
		GM.game_start_count = 1
		GM.first_loop = 0
	elif GM.loop_count == 0:
		GM.first_loop = 1
	if ((GM.main_menu_count%2) == 1) and (GM.game_start_count == 0):
		get_node("/root/UpgradeShop/UILayer").visible = false
		get_tree().paused = true	 
		GM.emit_signal("ahhh")
		GM.loop_count = 5
		get_tree().change_scene_to_file("res://scenes/game.tscn")
		GM.pause_resume_count = 0
	elif ((GM.main_menu_count%2) == 0) and (GM.game_start_count == 0):
		get_node("/root/UpgradeShop/UILayer").visible = false
		get_tree().paused = true	 
		GM.emit_signal("ahhh")
		GM.loop_count = 5
		get_tree().change_scene_to_file("res://scenes/game.tscn")
		GM.pause_resume_count = 0
	elif ((GM.main_menu_count%2) == 1) and (GM.game_start_count == 1):
		get_node("/root/UpgradeShop/UILayer").visible = false
		get_tree().paused = true	 
		GM.emit_signal("ahhh") 
		GM.loop_count = 5
		get_tree().change_scene_to_file("res://scenes/game.tscn")
		GM.pause_resume_count = 0
	elif ((GM.main_menu_count%2) == 0) and (GM.game_start_count == 1):
		get_node("/root/UpgradeShop/UILayer").visible = false
		get_tree().paused = true	 
		GM.emit_signal("ahhh")
		GM.loop_count = 5
		get_tree().change_scene_to_file("res://scenes/game.tscn")
		GM.pause_resume_count = 0
	if GM.main_menu_count > 0:
		GM.emit_signal("continue_option")
		GM.pause_resume_count = 0
		
		

		
