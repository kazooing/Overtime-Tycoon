extends TextureProgressBar

# note: sanity bar decreases downwards (100 top, 0 bottom)
func decreaseSanity (amount):
	GM.curSanity -= amount
	value = GM.curSanity


func _on_texture_button_pressed() -> void:
	decreaseSanity(20)
