extends VBoxContainer

var game_index = 0
const games = ["Pong","Pong","Pack_man","Game3"]

func _select_fx():
	var selectFX = get_node("/root/5 More Minutes/MainMenu/SelectFX")
	selectFX.playing = true

# ======== OPTIONS ========
func _on_option_button_item_selected(index):
	_select_fx()
	game_index = index

func _on_option_button_focus_entered():
	_select_fx()

func _on_option_button_mouse_entered():
	_select_fx()

# ======== START ========
func _on_start_pressed():
	get_tree().change_scene_to_file("res://Scenes/Game/Levels/" + games[game_index] + ".tscn")

func _on_start_focus_entered():
	_select_fx()

func _on_start_mouse_entered():
	_select_fx()

# ======== SETTINGS ========
func _on_settings_pressed():
	pass

func _on_settings_focus_entered():
	_select_fx()

func _on_settings_mouse_entered():
	_select_fx()

# ======== QUIT ========
func _on_quit_game_pressed():
	get_tree().quit()

func _on_quit_game_focus_entered():
	_select_fx()

func _on_quit_game_mouse_entered():
	_select_fx()
