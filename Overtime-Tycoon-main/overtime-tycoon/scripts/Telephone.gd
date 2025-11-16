extends Area2D
var pressed = false
@onready var start_pos = get_parent().global_position
var mouse_pos: Vector2
var correction: Vector2
var ease_vector: Vector2

func _ready() -> void:
	var button = $Button
	button.button_down.connect(on_press)
	button.button_up.connect(on_release)

func _process(delta: float) -> void:
	mouse_pos = get_global_mouse_position()
	if pressed:
		ease_vector = square_ease(global_position, mouse_pos, 0.05)
		global_position.x = move_toward(global_position.x, mouse_pos.x, ease_vector.x * delta)
		global_position.y = move_toward(global_position.y, mouse_pos.y, ease_vector.y * delta)
		$"Telephone Sprite".rotation = deg_to_rad(10)
	else:
		ease_vector = 0.3 * square_ease(global_position, start_pos, 10)
		global_position.x = move_toward(global_position.x, start_pos.x, ease_vector.x * delta)
		global_position.y = move_toward(global_position.y, start_pos.y, ease_vector.y * delta)
		$"Telephone Sprite".rotation = 0
	
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

func on_press():
	pressed = true

func on_release():
	pressed = false
