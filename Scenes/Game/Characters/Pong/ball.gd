extends CharacterBody2D

const SPEED = 500.0

func _physics_process(delta):
	var directionx = Input.get_axis("ui_left", "ui_right")
	var directiony = Input.get_axis("ui_up", "ui_down")
	
	velocity.x = directionx * SPEED
	velocity.y = directiony * SPEED
	#print(velocity.x, velocity.y)
	delta = delta
	move_and_slide()
