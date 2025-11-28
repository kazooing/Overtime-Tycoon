extends AnimatedSprite2D

#right now, meeting will only be run once and player need to exit and open it 
#again if they want to run it again

signal finished(reward: float, pos: Vector2)
signal decrease(amount: float)
signal on_penalty(confirm:bool, object: Node)
signal meeting_start
signal meeting_finish

var count = 0
enum{
	NOMEET,
	HASMEET,
	INMEET,
	AWAITHOLD,
	HOLDING,
}
var state = NOMEET
var open = false
var hold_timer_remain: float

@onready var progress = $TextureProgressBar
@onready var meeting_held = $MeetingHeld
@onready var first_timer = $MeetingDuration
@onready var sanity_timer = $SanityReduction
@onready var cue_timer = $CueTimer
@onready var held_timer = $HeldTimer
@onready var label = $Label
@onready var rng = RandomNumberGenerator.new()
@onready var audio_cue = get_node("Audio_cue")
@onready var bg_audio = get_node("bg_audio")

func _on_meeting_opener_closing_meeting() -> void:
	$Button.disabled = true
	open = false

func _on_meeting_opener_opening_meeting() -> void:
	open = true
	$Button.disabled = false
	$Button.visible = true
	#to make sure the meeting timer still runs in the background
	if state == NOMEET:
		display_meetingless()
	else:
		display_meeting()
	
	if state == HASMEET:
		start_meeting()
	else:
		print("not reset")
		print(first_timer.time_left)

func _process(_delta: float) -> void:
	if state == HOLDING:
		progress.value = held_timer.time_left

func start_meeting():
	display_meeting()
	meeting_start.emit()
	first_timer.start(rng.randi_range(5,9))
	start_sanity_drain()
	play_audio(bg_audio)
	print("open")
	state = INMEET
	hold_timer_remain = 5

func _on_meeting_duration_timeout() -> void:
	cue_timer.start()
	print("This is time at audio cue ", first_timer.time_left)
	state = AWAITHOLD
	print("Audio cue starts")
	play_audio(audio_cue)

#detects if the button is being pressed
func _on_button_button_down() -> void:
	frame = 1
	if state == AWAITHOLD:
		#$Button.visible = false
		#meeting_held.visible = true
		audio_cue.volume_db = -5
		state = HOLDING
		count = 3
		held_timer.start(hold_timer_remain)
		progress.visible = true
		cue_timer.stop()

func _on_button_button_up() -> void:
	hold_timer_remain = held_timer.time_left
	if state == HOLDING:
		state = AWAITHOLD
	await get_tree().create_timer(0.1).timeout
	frame = 0
	if state != AWAITHOLD:
		return
	
	if held_timer.time_left > 0.3:
		#meeting_held.visible = false
		progress.visible = false
		decrease.emit(20)
		if held_timer.time_left > 3:
			print("OKAY THATS NOW HOW TAKING CALLS WORKS", held_timer.time_left)
			held_timer.stop()
			task_failed(5, 3, 4)
		else:
			held_timer.stop()
			print("ATLEAST YOU PUT IN SOME EFFORT", held_timer.time_left)
			task_failed(10, 0, 1)

#if the button is held for 5 seconds, sanity won't be reduced further
func _on_held_timer_timeout() -> void:
	progress.visible = false
	#meeting_held.visible = false
	frame = 0
	audio_cue.stop()
	count = 4
	print("Audio stop")
	finish_meeting()

#if button isn't pressed in 2 seconds, sanity is reduced		
func _on_cue_timer_timeout() -> void:
	if state != AWAITHOLD:
		return
	decrease.emit(15)
	state = INMEET
	task_failed(5, 5, 7)

func _on_sanity_reduction_timeout() -> void:
	decrease.emit(4)
	print(GM.curSanity)

#if meeting duration is done, money will be given
func finish_meeting(reward: float = 20) -> void:
	if state == HASMEET or state == NOMEET:
		return
	
	bg_audio.stop()
	print("Meeting Finished")
	finished.emit(reward, global_position)
	stop_sanity_drain()
	state = NOMEET
	if open:
		display_meetingless()
	meeting_finish.emit()


func play_audio(audio: AudioStreamPlayer2D):
	if audio.playing:
		return
	audio.play()

func display_meetingless():
	self_modulate = Color(0.2,0.2,0.2,1)
	label.self_modulate = Color(1,1,1,1)

func display_meeting():
	self_modulate = Color(1,1,1,1)
	label.self_modulate = Color(0,0,0,0)

func has_meeting():
	state = HASMEET
	#completely psychotic solution to checking if the app is open or not, mb
	if open:
		start_meeting()

func cancel_meeting():
	state = NOMEET

func start_sanity_drain():
	sanity_timer.start()
	on_penalty.emit(true, self)

func stop_sanity_drain():
	sanity_timer.stop()
	on_penalty.emit(false, self)

func task_failed(reward:float, penalty_from:float, penalty_to:float, sound: bool = true):
	stop_all_timers()
	if sound:
		$fail.play()
	audio_cue.stop()
	state = INMEET
	await get_tree().create_timer(rng.randf_range(penalty_from,penalty_to)).timeout
	finish_meeting(reward)

func force_fail():
	if state == NOMEET:
		return
	if state == HASMEET:
		get_parent().no_meeting.emit()
		return
	task_failed(2, 0, 0, false)

func stop_all_timers():
	cue_timer.stop()
	first_timer.stop()
	held_timer.stop()
