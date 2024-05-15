extends Area2D

func _on_body_entered(_body):
	var score = get_node("/root/Pack-man/PlayerScore")
	score.set("text",int(score.text)+10)
	queue_free()
