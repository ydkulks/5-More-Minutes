extends CharacterBody2D

const SPEED = 500.0

func _physics_process(delta):
	var direction = Input.get_axis("WASD-up", "WASD-down")
	velocity.y = direction * SPEED
	delta = delta
	move_and_slide()
