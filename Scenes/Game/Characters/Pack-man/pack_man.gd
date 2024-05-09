extends CharacterBody2D


const SPEED = 100.0
@onready var anim = get_node("AnimatedSprite2D")

func _physics_process(_delta):
	var direction_x = Input.get_axis("WASD-left", "WASD-right")
	var direction_y = Input.get_axis("WASD-up", "WASD-down")
	if direction_x:
		velocity.x = direction_x * SPEED
		if direction_x > 0:
			anim.play("right")
		if direction_x < 0:
			anim.play("left")
	if direction_y:
		velocity.y = direction_y * SPEED
		if direction_y > 0:
			anim.play("down")
		if direction_y < 0:
			anim.play("up")

	move_and_slide()
