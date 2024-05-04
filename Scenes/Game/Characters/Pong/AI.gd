extends CharacterBody2D

const SPEED = 300.0
@onready var initial_position = position.x

func _physics_process(delta):
	delta = delta
	position.x = initial_position
	var Ball = get_node("/root/5 More Minutes/Pong/Ball")
	if Ball.position.y < position.y:
		velocity.y = -0.5 * SPEED
	if Ball.position.y > position.y:
		velocity.y = 0.5 * SPEED
	if Ball.position.y == position.y:
		velocity.y = 0
	move_and_slide()
