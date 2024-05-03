extends CharacterBody2D

const SPEED = 500.0

func _physics_process(delta):
	var direction = Input.get_axis("WASD-up", "WASD-down")
	velocity.y = direction * SPEED
	delta = delta
	move_and_slide()


func _on_area_2d_body_entered(body):
	var ball = get_node("/root/5 More Minutes/Pong/Ball")
	if body == ball:
		print("Center")
		#ball.position = Vector2(1, randf() * 2 - 1).normalized()
