extends Node2D

signal text_finished(move_by: float)
signal dialogue_ended(move_by: float)
signal reduce_sanity(amount: float)
signal call_dialogue_finished(reward: float)
signal affect_sanityBar(confirm:bool, object: Node)
signal meeting_dialogue_finished()
signal fail_meeting_task(reward, penalty_from, penalty_to)

var path = "res://dailogue test/tester.json"
var text_box = preload("res://dailogue test/textbox.tscn")
var dialogue_library = []
var monologue_library = []
var meeting_library = []
var response_library = []
var good_library = []
var sad_library = []
var dialogue = []
var code = 0 #keeps track of the current dialog

@onready var rng = RandomNumberGenerator.new()
@onready var sanity_timer = get_node("sanity_reduction")
@onready var speaker_list =[
	{
		"voice" : get_node("undeep male"),
		"pitch" : 1,
		"color" : Color.DARK_BLUE
	},
	{
		"voice": get_node("from telephone"),
		"pitch" : rng.randf_range(1,1.5),
		"color": Color.DARK_RED
	}
]


enum {
	EMPTY,
	DIALOGUE,
	MONOLOGUE,
	MEETING,
	RESPONSE,
	GOOD,
	SAD
}
var printing : int = EMPTY

func _ready() -> void:
	dialogue_library = read_JSON_data(path).get("DIALOGUE", [])
	monologue_library = read_JSON_data(path).get("MONOLOGUE", [])
	meeting_library = read_JSON_data(path).get("MEETING", [])
	response_library = read_JSON_data(path).get("RESPONSE", [])
	good_library = read_JSON_data(path).get("GOOD", [])
	sad_library = read_JSON_data(path).get("SAD", [])


var count = 0
var recent_text:Node
func next():
	if count >= dialogue.size():
		finish()
		return
	print("where instantiate happens")
	var new_text = text_box.instantiate()
	
	add_child(new_text)
	new_text.is_finished.connect(on_text_finish)
	new_text.tween_finished.connect(on_tween_finish)
	recent_text = new_text


func on_text_finish(box_code):
	if box_code != code:
		pass
		return
	count += 1
	text_finished.emit(-400)

func on_tween_finish(source):
	source.is_finished.disconnect(on_text_finish)
	source.tween_finished.disconnect(on_tween_finish)
	next()

func read_JSON_data(file_path):
	var file = FileAccess.open(file_path, FileAccess.READ)
	var data = file.get_as_text()
	file.close()
	
	var json = JSON.new()
	if json.parse(data) != OK:
		return {}
	return json.get_data()

func finish(fail: bool = false):
	var was_printing = printing
	print("okay it should STOP NOW")
	dialogue = []
	dialogue_ended.emit(-300)
	await child_exiting_tree
	
	count = 0
	if was_printing == DIALOGUE:
		var reward = 0 if fail else GM.add_money_telephone
		affect_sanityBar.emit(false, self)
		sanity_timer.stop()
		call_dialogue_finished.emit(reward)
	elif was_printing == MEETING:
		if fail:
			fail_meeting_task.emit(5, 0, 1)
		else:
			meeting_dialogue_finished.emit()
	if not fail:
		printing = EMPTY

var prev_dia = -1
func _on_telephone_call_started() -> void:
	if printing == DIALOGUE:
		return
	elif printing != EMPTY:
		finish(true)
		print("TELEPHONE INTERUPPTED", printing)
	
	sanity_timer.start()
	affect_sanityBar.emit(true, self)
	prev_dia = await dialogue_from_dict(DIALOGUE, dialogue_library, prev_meet)


func _on_sanity_reduction_timeout() -> void:
	reduce_sanity.emit(3)


var prev_mon:int = -1
func _on_monologue_timer_timeout() -> void:
	if printing != EMPTY:
		print("MONOLOGUE STOPPED")
		return
	
	if rng.randi_range(0,5) == 0:
		prev_mon = await dialogue_from_dict(MEETING, monologue_library, prev_meet)

var prev_meet: int = -1
func _on_meeting_dialogue() -> void:
	if printing == MEETING:
		return
	elif printing != EMPTY:
		finish(true)
	
	prev_meet = await dialogue_from_dict(MEETING, meeting_library, prev_meet)

func dialogue_from_dict(type: Variant, dict: Dictionary, previous: int = -1) -> int:
	if count < dialogue.size():
		await recent_text.tween_finished
	
	code += 1
	count = 0
	printing = type
	if printing == DIALOGUE: print("IM JUST CHECKING OKAY")
	var num = rng.randi_range(1, dict.size())
	if num == previous:
		num = rng.randi_range(1,dict.size())
	dialogue = dict[str(num)]
	print(dialogue)
	next()
	return num

var prev_good: int = -1
func _on_ending_good_timeout() -> void:
	if printing == GOOD:
		return
	elif printing != EMPTY:
		finish(true)
	prev_good = await dialogue_from_dict(GOOD, good_library, prev_good)

var prev_sad: int = -1
func _on_ending_sad_timeout() -> void:
	if printing == SAD:
		return
	elif printing != EMPTY:
		finish(true)
	prev_good = await dialogue_from_dict(SAD, sad_library, prev_sad)
