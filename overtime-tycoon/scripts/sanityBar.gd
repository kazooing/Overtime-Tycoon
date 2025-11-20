extends TextureProgressBar

const recovery = 3

signal is_not_draining(confirm: bool)

@onready var timer = $Timer
var affecting_list: Array[Node]


func _ready() -> void:
	timer.start()
	if GM.restart == 1:
		GM.curSanity = 100
# note: sanity bar decreases downwards (100 top, 0 bottom)
func decreaseSanity(amount: float):
	value -= amount
	GM.curSanity = value
	print(GM.curSanity)


func _on_texture_button_pressed() -> void:
	decreaseSanity(20)


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
	value += recovery
	GM.curSanity = value
