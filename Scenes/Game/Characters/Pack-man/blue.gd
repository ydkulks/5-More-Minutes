extends CharacterBody2D

const SPEED = 70.0
@export var player:CharacterBody2D
@onready var nav_agent = $NavigationAgent2D as NavigationAgent2D
enum MODE{CHASE,SCATTER,FRIGHTENED}
var current_mode:MODE

func _ready():
	get_node("Global").set("wait_time",7)
	current_mode = MODE.CHASE

func _physics_process(_delta):
	var direction = to_local(nav_agent.get_next_path_position()).normalized()
	velocity = direction * SPEED
	move_and_slide()

func _on_timer_timeout():
	if current_mode == MODE.CHASE:
		nav_agent.target_position = player.global_position
	elif current_mode == MODE.SCATTER:
		nav_agent.target_position = Vector2(58.38561, 195.004)
		if nav_agent.is_navigation_finished():
			nav_agent.target_position = Vector2(331.4718, 206.2424)
	else :
		nav_agent.target_position = Vector2(0,0)

func _on_global_timeout():
	if current_mode == MODE.CHASE:
		get_node("Global").set("wait_time",20)
		current_mode = MODE.SCATTER
	elif current_mode == MODE.SCATTER:
		get_node("Global").set("wait_time",7)
		current_mode = MODE.CHASE
