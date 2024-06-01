extends Node2D

var flag = true

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		if not get_tree().paused:
			get_node("/root/SpaceInvaders/PauseMenu").visible = true
			get_tree().paused = true

func _on_space_ship_tree_exited():
	$GameOver.visible = true
	get_tree().paused = true
