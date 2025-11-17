extends Control

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
		get_node("/root/Game/WorkScene").visible = false
		get_node("/root/Game/PauseMenu").visible = false
		get_node("/root/Game/WorkScene/Canvas").visible = false
		get_tree().paused = true

func _on_start_pressed() -> void:
	get_node("/root/Game/StartScreen").visible = false
	get_node("/root/Game/WorkScene").visible = true
	get_node("/root/Game/PauseMenu").visible = true
	get_node("/root/Game/WorkScene/Canvas").visible = true
	get_tree().paused = false
	
func _on_quit_pressed() -> void:
	get_tree().quit()
