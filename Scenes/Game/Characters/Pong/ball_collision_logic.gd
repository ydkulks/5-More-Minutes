extends Area2D

@onready var Ball = get_node("/root/5 More Minutes/Pong/Ball")
@onready var _initial_pos = Ball.position

func _on_body_entered(body):
# Update the score
	if body == get_node("/root/5 More Minutes/Pong/Background/StaticBody2D4"):
		var computer_score = get_node("/root/5 More Minutes/Pong/ComputerScore")
		computer_score.set("text", int(computer_score.text) + 1)
		# Restart the position

	if body == get_node("/root/5 More Minutes/Pong/Background/StaticBody2D3"):
		var player_score = get_node("/root/5 More Minutes/Pong/PlayerScore")
		player_score.set("text", int(player_score.text) + 1)
		# Restart the position

	if ( body == get_node("/root/5 More Minutes/Pong/Background/StaticBody2D3") or 
	body == get_node("/root/5 More Minutes/Pong/Background/StaticBody2D4")) :
		var computer_score = get_node("/root/5 More Minutes/Pong/ComputerScore")
		var player_score = get_node("/root/5 More Minutes/Pong/PlayerScore")
		var max_score = 5
		# Reset position
		Ball.position = _initial_pos
		
		# Reset score
		if ( int(computer_score.text) >= max_score or int(player_score.text) >= max_score ):
			print("Game Over")
			computer_score.set("text", 0)
			player_score.set("text", 0)
