extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
@onready var bullet = load("res://Scenes/Game/Characters/SpaceInvaders/player_bullet.tscn")

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(_delta):
	# Add the gravity.
	#if not is_on_floor():
		#velocity.y += gravity * delta

	# Handle jump.
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		#velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("WASD-left", "WASD-right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()


func _on_timer_timeout():
	var bullet_pos = global_position
	var new_bullet = bullet.instantiate()
	get_node("/root/SpaceInvaders/Bullets").add_child(new_bullet)
	new_bullet.position = bullet_pos
	#new_bullet.velocity.y = 100
	

func _on_area_2d_body_entered(body):
	# Add 3 lives
	if body != self:
		queue_free()
