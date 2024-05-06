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
