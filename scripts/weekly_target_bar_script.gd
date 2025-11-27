extends TextureProgressBar


func _ready() -> void:
	max_value = GM.weekly_target
	call_deferred("start_tween")

func start_tween():
	var tween = get_tree().create_tween()
	var value_to_tween = GM.curMoney
	if value_to_tween > GM.weekly_target: value_to_tween = GM.weekly_target
	tween.tween_property(self, "value", value_to_tween, 7).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
