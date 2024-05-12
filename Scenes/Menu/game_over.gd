extends CanvasLayer

@onready var level = get_tree().current_scene

func _ready():
	if level == get_node("/root/Pong"):
		level = "pong"
	else:
		level = "packman"

func _on_play_again_pressed():
	get_tree().paused = false
	visible = false
	get_tree().reload_current_scene()

func _on_exit_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/5_more_minutes.tscn")


func _on_visibility_changed():
	var player = get_node("../PlayerScore")
	var computer = get_node("../ComputerScore")
	var score = get_node("./Control/Score")
	score.set("text",player.text)
	
	# Call global save function when player wins and beat their highscore
	if int(player.text) > int(computer.text):
		var highscore = GlobalScript.load_game()
		if highscore == null:
			GlobalScript.save_game()
		elif highscore["scores"].has("level"):
			if int(highscore["scores"][level]["player_score"]) < int(player.text):
				get_node("Control/ScoreLabel").set("text","New High Score!:")
				GlobalScript.save_game()
		else:
			get_node("Control/ScoreLabel").set("text","New High Score!:")
			GlobalScript.save_game()

func save():
	var save_dict = {
		"scores":{
		level : {
			"player_score" : int(get_node("Control/Score").text)
			}
		}
	}
	return save_dict

# Select FX

func _on_play_again_focus_entered():
	get_node("SelectFX").playing = true


func _on_play_again_mouse_entered():
	get_node("SelectFX").playing = true


func _on_exit_focus_entered():
	get_node("SelectFX").playing = true


func _on_exit_mouse_entered():
	get_node("SelectFX").playing = true
