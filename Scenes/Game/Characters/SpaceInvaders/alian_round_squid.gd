extends CharacterBody2D


const SPEED = 100.0
@onready var alian_bullet = load("res://Scenes/Game/Characters/SpaceInvaders/alian_bullet.tscn")
@onready var alian_bullet_right = load("res://Scenes/Game/Characters/SpaceInvaders/alian_bullet_right.tscn")
@onready var alian_bullet_left = load("res://Scenes/Game/Characters/SpaceInvaders/alian_bullet_left.tscn")

func _ready():
	get_node("AnimatedSprite2D").play("default")

func _physics_process(_delta):
	velocity.x = 1 * SPEED
	move_and_slide()


func _on_area_2d_body_entered(body):
	if body == get_node("/root/SpaceInvaders/Border/StaticBody2D3"):
		var current_pos = position
		position.x = 14
		position.y = current_pos.y + 25
	
	var bullets_node = get_node("/root/SpaceInvaders/Bullets")
	var bullet_count = bullets_node.get_child_count()
	if bullet_count > 0:
		#print("Has children of bullets")
		for child in bullets_node.get_children():
			if body == child:
				set_collision_layer_value(1,true)
				set_collision_layer_value(2,false)
				$Timer.set("wait_time", 0.5)
				$Timer.start()
				$AnimatedSprite2D.play("death")

func _on_timer_timeout():
	queue_free()


func _on_shoot_timeout():
	var alian_bullet_pos = global_position
	var space_ship_pos = get_node("/root/SpaceInvaders/SpaceShip").global_position
	var new_alian_bullet
	if space_ship_pos == alian_bullet_pos:
		new_alian_bullet = alian_bullet.instantiate()
	elif space_ship_pos > alian_bullet_pos:
		new_alian_bullet = alian_bullet_right.instantiate()
	else:
		new_alian_bullet = alian_bullet_left.instantiate()
	get_node("/root/SpaceInvaders/AlianBullets").add_child(new_alian_bullet)
	new_alian_bullet.position = alian_bullet_pos
