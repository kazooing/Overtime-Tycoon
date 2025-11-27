extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


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
	GM.day_count = 0
	GM.week_count = 1
