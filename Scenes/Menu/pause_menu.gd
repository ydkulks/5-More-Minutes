extends CanvasLayer

func _on_resume_pressed():
	visible = false
	get_tree().paused = false


func _on_settings_pressed():
	pass # Replace with function body.


func _on_tutorial_pressed():
	pass # Replace with function body.


func _on_exit_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/5_more_minutes.tscn")

# Select FX
func _on_resume_focus_entered():
	get_node("SelectFX").playing = true


func _on_resume_mouse_entered():
	get_node("SelectFX").playing = true


func _on_settings_focus_entered():
	get_node("SelectFX").playing = true


func _on_settings_mouse_entered():
	get_node("SelectFX").playing = true


func _on_tutorial_focus_entered():
	get_node("SelectFX").playing = true


func _on_tutorial_mouse_entered():
	get_node("SelectFX").playing = true


func _on_exit_focus_entered():
	get_node("SelectFX").playing = true


func _on_exit_mouse_entered():
	get_node("SelectFX").playing = true
