extends CanvasLayer

@onready var money_gained = $Main/label_money_gained
@onready var total_money = $Main/label_total_money
#@onready var week_goal = $Main/label_week_goal
@onready var tasks_done = $Task/tasks_done

func _ready() -> void:
	get_node("/root/DayRecap/PauseLayer").visible = true
	total_money.text += str(GM.curMoney)
	money_gained.text += str(GM.money_gained_per_scene)
	if GM.tasks[0]["owned"]: tasks_done.text += "Calls done: " + str(GM.calls_done_per_scene) + "\n"
	if GM.tasks[1]["owned"]: tasks_done.text += "Spreadsheets done: " + str(GM.spreadsheets_done_per_scene) + "\n"
	if GM.tasks[2]["owned"]: tasks_done.text += "Meetings done: " + str(GM.meetings_done_per_scene) + "\n"
	
			


func _on_texture_button_pressed() -> void:
	var tween = get_tree().create_tween()
	tween.tween_property(self,"offset:x", -1280, 1).set_trans(Tween.TRANS_SINE)
	tween.finished.connect(_on_slide_finished)
	get_node("/root/DayRecap/PauseLayer").visible = false
func _on_slide_finished():
	get_tree().change_scene_to_file("res://scenes/upgrade_shop_scene.tscn")
