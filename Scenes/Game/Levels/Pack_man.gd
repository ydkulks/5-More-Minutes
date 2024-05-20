extends Node2D

var pill_counter:int = 0
var pill_pos:Array = []
var energizer_scene

func _ready():
	energizer_scene = load("res://Scenes/Game/Characters/Pack-man/cherry.tscn")

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		if not get_tree().paused:
			get_node("/root/Pack-man/PauseMenu").visible = true
			get_tree().paused = true

func _on_timer_timeout():
	get_tree().paused = true
	get_node("/root/Pack-man/GameOver").visible = true


func _on_pills_child_exiting_tree(node):
	get_node("Pill").set("playing",true)
	var cherry_time = 70 #When cherry should populate (80)
	pill_pos.append(node.global_position)
	GlobalScript.add_pill_pos(node.global_position)
	pill_counter += 1
	if pill_counter == cherry_time:
		var cherry_pos = pill_pos[int(randf_range(0,cherry_time))]
		var cherry_instanced = energizer_scene.instantiate()
		$Collectables/Energizers.add_child(cherry_instanced)
		cherry_instanced.position = cherry_pos
		cherry_instanced.scale = Vector2(0.5,0.5)
	if pill_counter >= 92:
		get_tree().paused = true
		get_node("/root/Pack-man/GameOver").visible = true
