extends Node2D


func _input(event):
	if event.is_action_pressed("ui_cancel"):
		if not get_tree().paused:
			get_node("/root/Pack-man/PauseMenu").visible = true
			get_tree().paused = true
 


func _on_timer_timeout():
	get_tree().paused = true
	get_node("/root/Pack-man/GameOver").visible = true
