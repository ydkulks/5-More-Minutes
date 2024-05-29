extends CharacterBody2D


const SPEED = 100.0

func _ready():
	get_node("AnimatedSprite2D").play("default")

func _physics_process(_delta):
	velocity.x = 1 * SPEED
	move_and_slide()


func _on_area_2d_body_entered(body):
	if body == get_node("/root/SpaceInvaders/Border/StaticBody2D3"):
		var current_pos = position
		position.x = 13
		position.y = current_pos.y + 25
	
	var bullets_node = get_node("/root/SpaceInvaders/Bullets")
	var bullet_count = bullets_node.get_child_count()
	if bullet_count > 0:
		#print("Has children of bullets")
		for child in bullets_node.get_children():
			if body == child:
				set_collision_layer_value(1,true)
				set_collision_layer_value(2,false)
				$Timer.set("wait_time", 0.5)
				$Timer.start()
				$AnimatedSprite2D.play("death")

func _on_timer_timeout():
	queue_free()
