extends TextureProgressBar

var recovery = 3

signal is_not_draining(confirm: bool)
signal sanity_bar_zero()

@onready var timer = $Timer
var affecting_list: Array[Node]
var mult_decrease = 1	# sanity decreaser multiplier
var mult_increase = 1	# sanity recovery multiplier 

func _ready() -> void:
	timer.start()
	if GM.restart == 1:
		GM.curSanity = 100
# note: sanity bar decreases downwards (100 top, 0 bottom)
func decreaseSanity(amount: float):
	amount *= mult_decrease
	value -= amount
	GM.curSanity = value
	if value == 0: sanity_bar_zero.emit()
	print(GM.curSanity)


func new_affecting(confirm: bool, object: Node) -> void:
	#print("CHECKINGGGG  ", object)
	#print(affecting_list)
	if confirm:
		if affecting_list.find(object) >= 0 : return
		affecting_list.append(object)
		is_not_draining.emit(false)
		timer.stop()
		#print("new_decreaser")
	else:
		var index: int = affecting_list.find(object)
		if index >= 0:
			affecting_list.pop_at(index)
			#print("popped one thing from the affecting list")
		if affecting_list.is_empty():
			#print("back to doing normal things")
			timer.start()
			is_not_draining.emit(true)


func _on_timer_timeout() -> void:
	var recovery_after_mult = recovery*mult_increase
	value += recovery_after_mult
	GM.curSanity = value


func _on_work_scene_fail_all_tasks() -> void:
	affecting_list.clear()
