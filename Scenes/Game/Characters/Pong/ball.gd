extends CharacterBody2D

const SPEED = 300.0

func _ready():
	velocity.x = -0.005 * SPEED

func _physics_process(delta):
	var collision_object = move_and_collide(velocity * SPEED * delta)
	if collision_object:
		get_node("/root/Pong/Bounce").playing = true
		velocity = velocity.bounce(collision_object.get_normal())
