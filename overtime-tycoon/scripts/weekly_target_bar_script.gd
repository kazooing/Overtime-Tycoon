extends TextureProgressBar


func _ready() -> void:
	max_value = GM.weekly_target
	call_deferred("start_tween")

func start_tween():
	var tween = get_tree().create_tween()
	tween.tween_property(self, "value", GM.curMoney, 2).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
