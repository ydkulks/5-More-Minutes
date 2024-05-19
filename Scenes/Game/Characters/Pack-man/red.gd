extends CharacterBody2D

var SPEED = 70.0
#@export var player:CharacterBody2D
@onready var player = get_node("/root/Pack-man/Pack-man")
@onready var nav_agent = $NavigationAgent2D as NavigationAgent2D
@onready var anim = get_node("AnimatedSprite2D")
var current_mode = GlobalScript.red_mode
var pill_pos = GlobalScript.pill_pos
var going_home:bool = false

func _ready():
	get_node("Global").set("wait_time",4)
	GlobalScript.connect("red_mode_changed", Callable(self , "_on_red_mode_changed"))
	GlobalScript.red_mode = GlobalScript.MODE.CHASE

func _physics_process(_delta):
	var direction = to_local(nav_agent.get_next_path_position()).normalized()
	velocity = direction * SPEED
	move_and_slide()

func _on_timer_timeout():
	if current_mode == GlobalScript.MODE.CHASE:
		nav_agent.target_position = player.global_position
	elif current_mode == GlobalScript.MODE.SCATTER:
		nav_agent.target_position = Vector2(323.1612, 50.82834)
		if nav_agent.is_navigation_finished():
			nav_agent.target_position = Vector2(367.0758, 67.00111)
	elif current_mode == GlobalScript.MODE.FRIGHTENED:
		if going_home:
			SPEED = 100.0
			nav_agent.target_position = Vector2(223, 122) #Home position
			anim.play("run")
			set_collision_mask_value(1, false)
			set_collision_mask_value(3,true)
			set_collision_layer_value(1, false)
			set_collision_layer_value(3,true)
			if nav_agent.is_navigation_finished(): #When reached home
				going_home = false
				SPEED = 70.0
				anim.play("default")
				GlobalScript.set_red_mode(GlobalScript.MODE.CHASE)
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
		get_node("Global").set("wait_time",25)
		GlobalScript.set_red_mode(GlobalScript.MODE.SCATTER)
	elif current_mode == GlobalScript.MODE.SCATTER:
		anim.play("default")
		SPEED = 70.0
		get_node("Global").set("wait_time",4)
		GlobalScript.set_red_mode(GlobalScript.MODE.CHASE)
	elif current_mode == GlobalScript.MODE.FRIGHTENED:
		anim.play("frightened")
		SPEED = 20.0
		get_node("Global").set("wait_time",20)
		GlobalScript.set_red_mode(GlobalScript.MODE.CHASE)

func _on_hud_child_exiting_tree(_node):
	GlobalScript.set_red_mode(GlobalScript.MODE.FRIGHTENED)
	anim.play("frightened")
	SPEED = 20.0

func _on_red_mode_changed(new_mode):
	current_mode = new_mode
	#anim.play("default")
	#SPEED = 70.0
	#get_node("Global").set("wait_time",25)


func _on_area_2d_body_entered(body): #frightened mode death
	if body == player && current_mode == GlobalScript.MODE.FRIGHTENED:
		#print("Red: Go to Ghost house")
		going_home = true
		var score = get_node("/root/Pack-man/PlayerScore")
		score.set("text", int(score.text)+500)
