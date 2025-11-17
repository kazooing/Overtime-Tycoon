extends CanvasLayer

func _ready() -> void:
	var tween = get_tree().create_tween()
	tween.tween_property(self, "offset:x", 0, 1).set_trans(Tween.TRANS_SINE)

func _on_texture_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/game.tscn")
	GM.loop_count = 1
