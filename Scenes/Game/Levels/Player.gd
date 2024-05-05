extends CharacterBody2D

const SPEED = 300.0
@onready var initial_position = position.x

func _physics_process(delta):
	var direction = Input.get_axis("WASD-up", "WASD-down")
	velocity.y = direction * SPEED
	position.x = initial_position
	delta = delta
	move_and_slide()
