extends Node2D

func _ready() -> void:
	await get_tree().create_timer(12).timeout
	get_node("Quit").visible = true
	get_node("QuitClicked").visible = true
	get_node("NewGame").visible = true
	get_node("NewGameClicked").visible = true
	get_node("Label").visible = true


func _on_quit_pressed() -> void:
	get_node("Quit").visible = false
	await get_tree().create_timer(0.1).timeout
	get_tree().quit()

func _on_new_game_pressed() -> void:
	get_node("NewGame").visible = false
	await get_tree().create_timer(0.1).timeout
	get_tree().change_scene_to_file("res://scenes/game.tscn")
	GM.loop_count = 0
	GM.main_menu_count = -1
	GM.restart = 1
	GM.day_count = 1
	GM.week_count = 1
