extends Area2D
var pressed = false
@onready var start_pos = get_parent().global_position
var mouse_pos: Vector2
var correction: Vector2
var ease_vector: Vector2
var is_ringing: bool = false
@onready var empty_ring = get_node("empty_ring")
@onready var ring = get_node("ringing")
@onready var sprite = get_node("Telephone Hand")

func _ready() -> void:
	var button = $Button
	button.button_down.connect(on_press)
	button.button_up.connect(on_release)

var sprite_alpha:float = 0 
func _process(delta: float) -> void:
	mouse_pos = get_global_mouse_position()
	if pressed:
		ease_vector = square_ease(global_position, mouse_pos, 0.05)
		global_position.x = move_toward(global_position.x, mouse_pos.x, ease_vector.x * delta)
		global_position.y = move_toward(global_position.y, mouse_pos.y, ease_vector.y * delta)
		sprite.modulate = Color(1,1,1,1)
		sprite_alpha = 1
		if not is_ringing:
			play_audio(empty_ring)
	else:
		ease_vector = 0.3 * square_ease(global_position, start_pos, 10)
		global_position.x = move_toward(global_position.x, start_pos.x, ease_vector.x * delta)
		global_position.y = move_toward(global_position.y, start_pos.y, ease_vector.y * delta)
		
		if empty_ring.playing:
			empty_ring.stop()
	
	if global_position.distance_to(start_pos) < 100:
		sprite_alpha = move_toward(sprite_alpha, 0, 1.1*delta)
		sprite.modulate = Color(1,1,1,sprite_alpha)
	else:
		sprite.modulate = Color(1,1,1,1)
	
	if has_overlapping_areas():
		pressed = false
	
	if global_position.distance_to(start_pos) > 600:
		pressed = false

func square_ease(pos1: Vector2, pos2: Vector2, minim:float) -> Vector2:
	var vector = pos2 - pos1
	var distance_sqr: float = pos1.distance_squared_to(pos2)
	var distance:float = sqrt(distance_sqr)
	var delta: float = 10*0.01*distance_sqr
	if distance == 0:
		return Vector2(0,0)
	if delta < minim:
		delta = 0.05
	vector = (delta/distance) * vector
	return abs(vector)

func play_audio(audio: AudioStreamPlayer2D):
	if audio.playing:
		return
	audio.play()

func on_press():
	pressed = true

func on_release():
	pressed = false

func disable():
	$Button.disabled = true

func enable():
	$Button.disabled = false


func _on_telephone_is_ringing(confirm: bool) -> void:
	is_ringing = confirm
	if confirm:
		empty_ring.stop()
		play_audio(ring)
	else:
		ring.stop()
