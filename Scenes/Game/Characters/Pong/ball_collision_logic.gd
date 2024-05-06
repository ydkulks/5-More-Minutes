extends Area2D

@onready var Ball = get_node("/root/Pong/Ball")
@onready var _initial_pos_ball = Ball.position

func _on_body_entered(body):
	# Update the score
	if body == get_node("/root/Pong/Background/StaticBody2D4"):
		var computer_score = get_node("/root/Pong/ComputerScore")
		computer_score.set("text", int(computer_score.text) + 1)

	if body == get_node("/root/Pong/Background/StaticBody2D3"):
		var player_score = get_node("/root/Pong/PlayerScore")
		player_score.set("text", int(player_score.text) + 1)

	if ( body == get_node("/root/Pong/Background/StaticBody2D3") or 
	body == get_node("/root/Pong/Background/StaticBody2D4")) :
		var computer_score = get_node("/root/Pong/ComputerScore")
		var player_score = get_node("/root/Pong/PlayerScore")
		#var max_score = 5
		# Reset position
		Ball.position = _initial_pos_ball
		Ball.velocity.y = 0
		
		# Choose who gets the ball based on who is winning
		if computer_score.text > player_score.text:
			Ball.velocity.x = -0.005 * 300.0
		if computer_score.text < player_score.text:
			Ball.velocity.x = 0.005 * 300.0
		if computer_score.text == player_score.text:
			Ball.velocity.x = -0.005 * 300.0
		
		get_node("/root/Pong/Score").playing = true
		
		# Reset score
		#if ( int(computer_score.text) >= max_score or int(player_score.text) >= max_score ):
			#get_tree().paused = true
			#get_node("/root/Pong/GameOver").visible = true
			#computer_score.set("text", 0)
			#player_score.set("text", 0)
