extends CanvasLayer

func _ready() -> void:
	var tween = get_tree().create_tween()
	tween.tween_property(self, "offset:x", 0, 1).set_trans(Tween.TRANS_SINE)

func _on_texture_button_pressed() -> void:
	get_node("/root/UpgradeShop/PauseLayer").visible = false
	GM.loop_count = 1
	GM.day_count += 1
	GM.first_loop = 0
	print("This is day count ", + GM.day_count)
	if (GM.day_count%7) == 0:
		GM.week_count += 1
		print("This is week count ", + GM.week_count)
		GM.curMoney -= GM.max_value
		if GM.curMoney < 0:
			get_tree().change_scene_to_file("res://scenes/game_over_scene.tscn")
		else:
			get_tree().change_scene_to_file("res://scenes/game.tscn")
	else:
		get_tree().change_scene_to_file("res://scenes/game.tscn")
