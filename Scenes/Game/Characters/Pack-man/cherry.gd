extends Area2D

func _on_body_entered(_body):
	var HUD = get_node("/root/Pack-man/Collectables/Energizers/HUD/SprCherry0")
	var score = get_node("/root/Pack-man/PlayerScore")
	score.set("text",int(score.text)+100)
	HUD.visible = false
	queue_free()
