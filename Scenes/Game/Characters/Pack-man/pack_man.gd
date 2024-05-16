extends CharacterBody2D

const SPEED = 100.0
@export var red_enemy:CharacterBody2D
@export var pink_enemy:CharacterBody2D
@export var orange_enemy:CharacterBody2D
@export var blue_enemy:CharacterBody2D
@onready var anim = get_node("AnimatedSprite2D")
@onready var initial_position = position
@onready var red_pos = red_enemy.position
@onready var orange_pos = orange_enemy.position
@onready var pink_pos = pink_enemy.position
@onready var blue_pos = blue_enemy.position
var lives = 3

func _ready():
	get_tree().paused = true
	get_node("/root/Pack-man/ReadyGo").visible = true

func _physics_process(_delta):
	var direction_x = Input.get_axis("WASD-left", "WASD-right")
	var direction_y = Input.get_axis("WASD-up", "WASD-down")
	if direction_x:
		velocity.x = direction_x * SPEED
		velocity.y = 0
		if direction_x > 0:
			anim.play("right")
		if direction_x < 0:
			anim.play("left")
	elif direction_y:
		velocity.x = 0
		velocity.y = direction_y * SPEED
		if direction_y > 0:
			anim.play("down")
		if direction_y < 0:
			anim.play("up")

	move_and_slide()


func _on_area_2d_body_entered(body):
	if body==red_enemy || body==pink_enemy || body==orange_enemy || body==blue_enemy:
		position = initial_position
		red_enemy.position = red_pos
		pink_enemy.position = pink_pos
		orange_enemy.position = orange_pos
		blue_enemy.position = blue_pos
		# Lives counter
		lives = lives - 1
		if lives == 2:
			get_node("/root/Pack-man/Lives/SprLifecounter2").visible = false
			# Ready! Go! menu
			get_tree().paused = true
			get_node("/root/Pack-man/ReadyGo").visible = true
		if lives == 1:
			get_node("/root/Pack-man/Lives/SprLifecounter1").visible = false
			# Ready! Go! menu
			get_tree().paused = true
			get_node("/root/Pack-man/ReadyGo").visible = true
		if lives <= 0:
			get_node("/root/Pack-man/Lives/SprLifecounter0").visible = false
			get_tree().paused = true
			get_node("/root/Pack-man/GameOver").visible = true

