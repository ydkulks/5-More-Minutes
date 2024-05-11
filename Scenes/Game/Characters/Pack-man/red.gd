extends CharacterBody2D

const SPEED = 70.0
@export var player:CharacterBody2D
@onready var nav_agent = $NavigationAgent2D as NavigationAgent2D

#func _ready():
	#path_finder()

func _physics_process(_delta):
	var direction = to_local(nav_agent.get_next_path_position()).normalized()
	#print(direction)
	velocity = direction * SPEED
	move_and_slide()

func path_finder():
	nav_agent.target_position = player.global_position

func _on_timer_timeout():
	#print(player.global_position)
	path_finder()
