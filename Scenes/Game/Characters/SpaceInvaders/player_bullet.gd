extends CharacterBody2D


const SPEED = 300.0
const BULLET_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(_delta):
	velocity.y = BULLET_VELOCITY
	move_and_slide()

func _on_area_2d_body_entered(body):
	if body != self:
		queue_free()
