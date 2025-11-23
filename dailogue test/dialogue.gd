extends Node2D

signal text_finished(move_by: float)
signal dialogue_ended(move_by: float)
signal reduce_sanity(amount: float)
signal call_dialogue_finished
signal affect_sanityBar(confirm:bool, object: Node)

var path = "res://dailogue test/tester.json"
var text_box = preload("res://dailogue test/textbox.tscn")
var dialogue_library = []
var monologue_library = []
var dialogue = []
var running = false

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
	DIALOGUE,
	MONOLOGUE
}
var printing : int = MONOLOGUE

func _ready() -> void:
	dialogue_library = read_JSON_data(path).get("DIALOGUE", [])
	monologue_library = read_JSON_data(path).get("MONOLOGUE", [])
	dialogue = dialogue_library["1"]
	next()


var count = 0

func next():
	if count >= dialogue.size():
		finish()
		return
	running = true
	print("where instantiate happens")
	var new_text = text_box.instantiate()
	
	add_child(new_text)
	new_text.is_finished.connect(on_text_finish)
	new_text.tween_finished.connect(on_tween_finish)

func on_text_finish():
	count += 1
	text_finished.emit(-400)

func on_tween_finish(source):
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

func finish():
	print("okay it should STOP NOW")
	dialogue_ended.emit(-300)
	running = false
	count = 0
	if printing == DIALOGUE:
		affect_sanityBar.emit(false, self)
		sanity_timer.stop()
		call_dialogue_finished.emit()

func _on_telephone_call_started() -> void:
	if running and printing == DIALOGUE:
		return
	elif running:
		dialogue_ended.emit(-300)
	
	printing = DIALOGUE
	sanity_timer.start()
	affect_sanityBar.emit(true, self)
	var num = rng.randi_range(1,dialogue_library.size())
	
	dialogue = dialogue_library[str(num)]
	next()


func _on_sanity_reduction_timeout() -> void:
	reduce_sanity.emit(3)


func _on_monologue_timer_timeout() -> void:
	if running:
		return
	
	if rng.randi_range(0,5) == 0:
		printing = MONOLOGUE
		var num = rng.randi_range(1,monologue_library.size())
		dialogue = monologue_library[str(num)]
		next()
