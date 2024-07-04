extends CharacterBody2D


const SPEED = 300.0
const BULLET_VELOCITY = 50.0

func _physics_process(_delta):
	velocity.y = BULLET_VELOCITY
	velocity.x = 30.0
	move_and_slide()

func _on_area_2d_body_entered(body):
	if body != self:
		queue_free()
