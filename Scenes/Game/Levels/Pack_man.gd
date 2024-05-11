extends Node2D


func _input(event):
	if event.is_action_pressed("ui_cancel"):
		if not get_tree().paused:
			get_node("/root/Pack-man/PauseMenu").visible = true
			get_tree().paused = true
 
