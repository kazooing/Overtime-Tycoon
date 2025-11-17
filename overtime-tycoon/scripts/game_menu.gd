extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_node("/root/Game/PauseMenu/Background").visible = false
	get_node("/root/Game/PauseMenu/Pause Menu Box").visible = false
	
func _on_pause_pressed() -> void:
	get_node("/root/Game/PauseMenu/Background").visible = true
	get_node("/root/Game/PauseMenu/Pause Menu Box").visible = true
	get_tree().paused = true
	
func _on_resume_pressed() -> void:
	get_node("/root/Game/PauseMenu/Background").visible = false
	get_node("/root/Game/PauseMenu/Pause Menu Box").visible = false
	get_tree().paused = false
	
func _on_quit_pressed() -> void:
	get_tree().quit()
