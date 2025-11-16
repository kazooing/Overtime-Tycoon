extends TextureProgressBar


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	max_value = GM.weekly_target
	var tween = get_tree().create_tween()
	tween.tween_property(self, "value", GM.curMoney, 2).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
