extends CanvasLayer

@onready var dimmer = $back_dimmer
@onready var inspector = $inspector_panel
@onready var buy_button = $inspector_panel/buy_button
@onready var decor_icon = $inspector_panel/icon
@onready var decor_price = $inspector_panel/price

signal tween_dimmer_fade_in
signal tween_dimmer_fade_out
signal give_to_buy_button(price: int, id: String)

func _ready() -> void:
	var tween = get_tree().create_tween()
	tween.tween_property(self, "offset:x", 0, 1).set_trans(Tween.TRANS_SINE)


func open_inspector(title:String, desc:String, price:int, id:String):
	tween_dimmer_fade_in.emit()
	give_to_buy_button.emit(price, id)
	decor_icon.texture = load(GM.pajangan[int(id)]["icon"])
	$inspector_panel/title.text = title
	$inspector_panel/description.text = desc
	dimmer.visible = true
	decor_price.text = "$ " + str(price)
	#show dimmer 
	var tween = get_tree().create_tween()
	tween.tween_property(inspector, "position:x", 880, 0.3).set_trans(Tween.TRANS_SINE)
	
	

func _on_tween_dimmer_fade_in() -> void:
	var tween = get_tree().create_tween()
	tween.tween_property(dimmer, "color:a", 0.5, 0.3).set_trans(Tween.TRANS_SINE)

# when clicked outside inspector 
func _on_back_dimmer_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed:
		close_inspector()
		
func close_inspector():
	tween_dimmer_fade_out.emit()
	var tween = get_tree().create_tween()
	tween.tween_property(inspector, "position:x", 1280, 0.3)

func _on_tween_dimmer_fade_out() -> void:
	var tween = get_tree().create_tween()
	tween.tween_property(dimmer, "color:a", 0, 0.3).set_trans(Tween.TRANS_SINE)
	dimmer.visible = false
	
	
	

func _on_texture_button_pressed() -> void:
	get_node("/root/UpgradeShop/PauseLayer").visible = false
	GM.loop_count = 1
	GM.day_count += 1
	GM.first_loop = 0
	print("This is day count ", + GM.day_count)
	if (GM.day_count%7) == 0:
		GM.week_count += 1
		print("This is week count ", + GM.week_count)
		GM.curMoney -= GM.max_value
		if GM.curMoney < 0:
			get_tree().change_scene_to_file("res://scenes/game_over_scene.tscn")
		else:
			get_tree().change_scene_to_file("res://scenes/game.tscn")
	else:
		get_tree().change_scene_to_file("res://scenes/game.tscn")
