extends CanvasLayer

@onready var money_gained = $Main/label_money_gained
@onready var total_money = $Main/label_total_money
@onready var week_goal = $Main/label_week_goal
@onready var calls_done = $Task/label_calls_done

func _ready() -> void:
	total_money.text += str(GM.curMoney)
	money_gained.text += str(GM.money_gained_per_scene)
	calls_done.text +=  str(GM.calls_done_per_scene)


func _on_texture_button_pressed() -> void:
	var tween = get_tree().create_tween()
	tween.tween_property(self,"offset:x", -1280, 1).set_trans(Tween.TRANS_SINE)
	tween.finished.connect(_on_slide_finished)
	
func _on_slide_finished():
	get_tree().change_scene_to_file("res://scenes/upgrade_shop_scene.tscn")
