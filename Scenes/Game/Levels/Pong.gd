extends Node2D

@onready var computer_score = get_node("/root/Pong/ComputerScore")
@onready var player_score = get_node("/root/Pong/PlayerScore")

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		if not get_tree().paused:
			get_node("/root/Pong/PauseMenu").visible = true
			get_tree().paused = true

func _on_timer_timeout():
	get_tree().paused = true
	get_node("/root/Pong/GameOver").visible = true
	computer_score.set("text", 0)
	player_score.set("text", 0)
