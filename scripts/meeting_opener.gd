extends Sprite2D

signal opening_meeting()
signal closing_meeting()
signal close_programs(exception: Node)
signal meeting_ready
signal no_meeting

@onready var anim_player = $AnimationPlayer
@onready var ringer_timer = $ringer_timer
@onready var notif_anim = get_node("Notification/AnimationPlayer")
@onready var rng = RandomNumberGenerator.new()
var is_open = false
var has_meeting = false
var ring_cycle = 2
var pickup_window = 4
var in_X = 2
var animation = "Open and close meetingless"

func _ready() -> void:
	ringer_timer.start()

func _on_button_button_down() -> void:
	if not is_open:
		is_open = true
		anim_player.play(animation)
		close_programs.emit(self)
		opening_meeting.emit()
	else:
		is_open = false
		anim_player.play_backwards(animation)
		closing_meeting.emit()

func disable():
	$Button.disabled = true

func force_close(exception: Node):
	if exception == self or not is_open:
		return
	is_open = false
	anim_player.play_backwards("Open and close meeting")
	closing_meeting.emit()

var ringatt_count = 0
func _on_ringer_timer_timeout() -> void:
	if has_meeting:
			has_meeting = false
			notif_anim.play_backwards("Appear notif")
			ringer_timer.start(ring_cycle)
			print("NO MEETING CALLED")
			no_meeting.emit()
			animation = "Open and close meetingless"
			return
	
	if rng.randi_range(1,in_X) != 1 and ringatt_count < 4:
		ringatt_count += 1
		return
	
	has_meeting = true
	notif_anim.play("Appear notif")
	ringatt_count = 0
	ringer_timer.start(pickup_window)
	print("MEETING READY CALLED")
	meeting_ready.emit()
	animation = "Open and close meeting"


func _on_meeting_meeting_start() -> void:
	ringer_timer.stop()
	notif_anim.play_backwards("Appear notif")


func _on_meeting_meeting_finish() -> void:
	ringer_timer.start(ring_cycle)
	if is_open:
		is_open = false
		anim_player.play_backwards(animation)
		closing_meeting.emit()
	has_meeting = false
	animation = "Open and close meetingless"


func _on_screen_allow_meetings(confirm: bool) -> void:
	if not confirm:
		print("MEETINGS DISALLOWED")
		ringer_timer.stop()
		anim_player.play_backwards("Appear notif")
		no_meeting.emit()
		has_meeting = false
		animation = "Open and close meetingless"
	else:
		print("MEETINGS ALLOWED")
		ringer_timer.start(ring_cycle)
