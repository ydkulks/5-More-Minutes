extends CharacterBody2D

var SPEED = 70.0
@export var player:CharacterBody2D
@onready var nav_agent = $NavigationAgent2D as NavigationAgent2D
#enum MODE{CHASE,SCATTER,FRIGHTENED}
#var current_mode:MODE
@onready var anim = get_node("AnimatedSprite2D")
var pill_pos = GlobalScript.pill_pos
var current_mode = GlobalScript.blue_mode
var going_home:bool = false
var pill_counter:int

func _ready():
	get_node("Global").set("wait_time",7)
	GlobalScript.connect("blue_mode_changed", Callable(self , "_on_blue_mode_changed"))
	current_mode = GlobalScript.MODE.CHASE

func _physics_process(_delta):
	var direction = to_local(nav_agent.get_next_path_position()).normalized()
	velocity = direction * SPEED
	move_and_slide()

func _on_timer_timeout():
	if current_mode == GlobalScript.MODE.CHASE:
		#var pos_x = randf_range(40.0,400.0)
		#var pos_y = randf_range(32.0,238.0)
		#nav_agent.target_position = Vector2(pos_x, pos_y)
		var max_pill = len(pill_pos)
		nav_agent.target_position = pill_pos[int(randf_range(0,max_pill))]
	elif current_mode == GlobalScript.MODE.SCATTER:
		nav_agent.target_position = Vector2(58.38561, 195.004)
		if nav_agent.is_navigation_finished():
			nav_agent.target_position = Vector2(331.4718, 206.2424)
	elif current_mode == GlobalScript.MODE.FRIGHTENED:
		#nav_agent.target_position = Vector2(0,0)
		#print(current_mode)
		if going_home:
			SPEED = 100.0
			nav_agent.target_position = Vector2(241, 144) #Home position
			anim.play("run")
			set_collision_mask_value(1, false)
			set_collision_mask_value(3,true)
			set_collision_layer_value(1, false)
			set_collision_layer_value(3,true)
			if nav_agent.is_navigation_finished(): #When reached home
				going_home = false
				SPEED = 70.0
				anim.play("default")
				GlobalScript.set_blue_mode(GlobalScript.MODE.CHASE)
				set_collision_mask_value(1, true)
				set_collision_mask_value(3,false)
				set_collision_layer_value(1, true)
				set_collision_layer_value(3,false)
		else:
			var max_pill = len(pill_pos)
			nav_agent.target_position = pill_pos[int(randf_range(0,max_pill))]

func _on_global_timeout():
	if current_mode == GlobalScript.MODE.CHASE:
		anim.play("default")
		SPEED = 70.0
		get_node("Global").set("wait_time",20)
		GlobalScript.set_orange_mode(GlobalScript.MODE.SCATTER)
	elif current_mode == GlobalScript.MODE.SCATTER:
		anim.play("default")
		SPEED = 70.0
		get_node("Global").set("wait_time",7)
		GlobalScript.set_orange_mode(GlobalScript.MODE.CHASE)
	elif current_mode == GlobalScript.MODE.FRIGHTENED:
		anim.play("frightened")
		SPEED = 20.0
		get_node("Global").set("wait_time",20)
		GlobalScript.set_blue_mode(GlobalScript.MODE.CHASE)

func _on_blue_mode_changed(new_mode):
	current_mode = new_mode

func _on_pills_child_exiting_tree(_node):
	pill_counter += 1
	if pill_counter == 30: #30
		get_node("Timer").set("wait_time", 0.5)
		get_node("Global").set("wait_time", 20.0)
		if $Timer.is_inside_tree(): $Timer.start()
		if $Global.is_inside_tree(): $Global.start()


func _on_area_2d_2_body_entered(body):
	if body == player and current_mode == GlobalScript.MODE.FRIGHTENED:
		#print("Blue: Go to Ghost house")
		going_home = true
		var score = get_node("/root/Pack-man/PlayerScore")
		score.set("text", int(score.text)+500)


func _on_hud_child_exiting_tree(_node):
	GlobalScript.set_blue_mode(GlobalScript.MODE.FRIGHTENED)
	anim.play("frightened")
	SPEED = 20.0
