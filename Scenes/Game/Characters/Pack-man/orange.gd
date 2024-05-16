extends CharacterBody2D

const SPEED = 70.0
@export var player:CharacterBody2D
@onready var nav_agent = $NavigationAgent2D as NavigationAgent2D
enum MODE{CHASE,SCATTER,FRIGHTENED}
var current_mode:MODE
var pill_counter:int

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
		nav_agent.target_position = Vector2(260.2412, 118.4166)
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


func _on_pills_child_exiting_tree(_node):
	pill_counter += 1
	if pill_counter == 55: # 55
		$Timer.start(0.5)
		$Global.start(20.0)


func _on_area_2d_body_entered(body):
	if body == player:
		current_mode = MODE.CHASE


func _on_area_2d_body_exited(body):
	if body == player:
		current_mode = MODE.SCATTER
