extends Area2D

func _on_body_entered(body):
	body.position.x = 440


func _on_right_tp_body_entered(body):
	body.position.x = 5 
