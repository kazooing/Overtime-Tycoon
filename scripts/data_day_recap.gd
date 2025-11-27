extends CanvasLayer

@onready var money_gained = $Main/label_money_gained
@onready var total_money = $Main/label_total_money
#@onready var week_goal = $Main/label_week_goal
@onready var tasks_done = $Task/tasks_done

func _ready() -> void:
	get_node("/root/DayRecap/PauseLayer").visible = true
	
	total_money.text += str(GM.curMoney)
	money_gained.text += str(GM.money_gained_per_scene)
	$Main/label_weekly_target.text += str(GM.weekly_target)
	$amount_days_left.text = str(5-((GM.day_count+1)%5))
	
	if GM.tasks[0]["owned"]: tasks_done.text += "Calls done: " + str(GM.calls_done_per_scene) + "\n"
	if GM.tasks[1]["owned"]: tasks_done.text += "Spreadsheets done: " + str(GM.spreadsheets_done_per_scene) + "\n"
	if GM.tasks[2]["owned"]: tasks_done.text += "Meetings done: " + str(GM.meetings_done_per_scene) + "\n"
	
	if GM.sanity_hits_zero_counter != 0:
		var amount_to_substract = 0
		for i in range(1, GM.sanity_hits_zero_counter+1):
			amount_to_substract += i
		amount_to_substract *= 10
		print(amount_to_substract)
		var total_money_after_substract = max(GM.curMoney-amount_to_substract, 0) 
		total_money.text += " [color=red]- " + str(amount_to_substract) + " = " + str(total_money_after_substract) + "[/color]"
		GM.curMoney = total_money_after_substract
		tasks_done.text += "[color=red]Penalty: " + str(GM.sanity_hits_zero_counter) + "[/color]"
		
	
	
			


func _on_texture_button_pressed() -> void:
	$"../AudioStreamPlayer".play()
	var tween = get_tree().create_tween()
	tween.tween_property(self,"offset:x", -1280, 1).set_trans(Tween.TRANS_SINE)
	tween.finished.connect(_on_slide_finished)
	get_node("/root/DayRecap/PauseLayer").visible = false
func _on_slide_finished():
	get_tree().change_scene_to_file("res://scenes/upgrade_shop_scene.tscn")
