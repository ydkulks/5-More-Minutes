extends CanvasLayer

func _on_play_again_pressed():
	get_tree().paused = false
	visible = false
	get_tree().reload_current_scene()

func _on_exit_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/5_more_minutes.tscn")


func _on_visibility_changed():
	var pong = get_node("../PlayerScore")
	var score = get_node("./Control/Score")
	score.set("text",pong.text)
