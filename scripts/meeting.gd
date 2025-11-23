extends AnimatedSprite2D

#right now, meeting will only be run once and player need to exit and open it 
#again if they want to run it again

signal finished(reward: float, pos: Vector2)
signal decrease(amount: float)

var count = 0
@onready var progress = $TextureProgressBar
@onready var meeting_held = $MeetingHeld
@onready var total_timer = $MeetingDuration
@onready var sanity_timer = $SanityReduction
@onready var cue_timer = $CueTimer
@onready var held_timer = $HeldTimer
@onready var rng = RandomNumberGenerator.new()
@onready var audio_cue = get_node("Audio_cue")

func _on_meeting_opener_closing_meeting() -> void:
	$Button.disabled = true

func _on_meeting_opener_opening_meeting() -> void:
	$Button.disabled = false
	$Button.visible = true
	#to make sure the meeting timer still runs in the background
	if count == 0:	
		total_timer.start()
		sanity_timer.start()
		print("open")
		count = 1
	else:
		print("not reset")
		print(total_timer.time_left)
	
func _process(_delta: float) -> void:
	var detect = 0
	if count == 1:
		#audio cue starts between 5 to 9 seconds of meeting duration
		detect =  total_timer.time_left - rng.randi_range(5,10)
		if detect < 0:
			cue_timer.start()
			print("This is time at audio cue ", total_timer.time_left)
			count = 2
			print("Audio cue starts")
			play_audio(audio_cue)
	elif count == 3:
		progress.visible = true
		progress.value = held_timer.time_left

#detects if the button is being pressed
func _on_button_button_down() -> void:
	if count == 2:
		$Button.visible = false
		meeting_held.visible = true
		count = 3
		held_timer.start()
		cue_timer.stop()

func _on_button_button_up() -> void:
	if held_timer.time_left > 0:
		meeting_held.visible = false
		progress.visible = false
		decrease.emit(15)
		held_timer.stop()
		audio_cue.stop()
		
#if the button is held for 5 seconds, sanity won't be reduced further
func _on_held_timer_timeout() -> void:
	progress.visible = false
	meeting_held.visible = false
	audio_cue.stop()
	count = 4
	print("Audio stop")

#if button isn't pressed in 2 seconds, sanity is reduced		
func _on_cue_timer_timeout() -> void:
	decrease.emit(15)
	audio_cue.stop()
	
#sanity reduced every second (it's actually only 4, I don't know how to disable 
#sanity recovery of 3 every second)
func _on_sanity_reduction_timeout() -> void:
	decrease.emit(7)
	print(GM.curSanity)
	

#if meeting duration is done, money will be given
func _on_meeting_duration_timeout() -> void:
	print("Meeting Finished")
	finished.emit(20, global_position)
	sanity_timer.stop()
	count = 0
	
func play_audio(audio: AudioStreamPlayer2D):
	if audio.playing:
		return
	audio.play()
