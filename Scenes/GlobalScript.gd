extends Node

var save_file = "user://5MoreMinutes.save"

var lives = 3 #Pac-man lives counter

var pill_pos:Array = [Vector2(256, 232), Vector2(272, 224), Vector2(272, 200), Vector2(296, 200), 
 Vector2(320, 200), Vector2(336, 192), Vector2(336, 224), Vector2(352, 232), Vector2(376, 232), 
 Vector2(400, 232), Vector2(368, 216), Vector2(376, 200), Vector2(400, 200), Vector2(400, 176), 
 Vector2(384, 168), Vector2(359, 168), Vector2(192, 232), Vector2(176, 224), Vector2(176, 200), 
 Vector2(151, 200), Vector2(128, 200), Vector2(112, 192), Vector2(113, 224), Vector2(96, 232), 
 Vector2(80, 216), Vector2(72, 232), Vector2(48, 232), Vector2(72, 200), Vector2(48, 200), 
 Vector2(48, 175), Vector2(64, 168), Vector2(88, 168), Vector2(112, 168), Vector2(112, 144), 
 Vector2(112, 120), Vector2(112, 96), Vector2(112, 72), Vector2(88, 72), Vector2(64, 72), 
 Vector2(48, 64), Vector2(56, 40), Vector2(80, 40), Vector2(104, 40), Vector2(128, 40), Vector2(128, 64), 
 Vector2(144, 80), Vector2(152, 56), Vector2(176, 56), Vector2(200, 56), Vector2(224, 56), 
 Vector2(248, 56), Vector2(272, 56), Vector2(296, 56), Vector2(320, 56), Vector2(328, 40), 
 Vector2(352, 40), Vector2(376, 40), Vector2(400, 40), Vector2(400, 64), Vector2(384, 72), 
 Vector2(360, 72), Vector2(336, 72), Vector2(336, 96), Vector2(336, 120), Vector2(336, 144), 
 Vector2(336, 168), Vector2(248, 200), Vector2(240, 184), Vector2(200, 200), Vector2(208, 184), 
 Vector2(200, 168), Vector2(192, 88), Vector2(176, 79), Vector2(256, 88), Vector2(272, 80), 
 Vector2(144, 104), Vector2(144, 128), Vector2(144, 152), Vector2(152, 168), Vector2(176, 168)]

signal pos_added(pos:Vector2)
func add_pill_pos(pos:Vector2):
	pill_pos.append(pos)
	#print(pill_pos)
	emit_signal("pos_added", pill_pos)

# Red ghost states
enum MODE{CHASE,SCATTER,FRIGHTENED}
var red_mode:MODE
signal red_mode_changed(new_mode)
func set_red_mode(new_mode):
	red_mode = new_mode
	emit_signal("red_mode_changed", new_mode)
# Pink ghost states
var pink_mode:MODE
signal pink_mode_changed(new_mode)
func set_pink_mode(new_mode):
	pink_mode = new_mode
	emit_signal("pink_mode_changed", new_mode)

func save_game():
	var save_game_file = FileAccess.open(save_file, FileAccess.WRITE)
	var save_nodes = get_tree().get_nodes_in_group("Persist")
	for node in save_nodes:
		if node.scene_file_path.is_empty():
			print("Instanced")
			continue
	
		if !node.has_method("save"):
			print("save() exists")
			continue
	
		var node_data = node.call("save")
	
		var json_string = JSON.stringify(node_data)
	
		save_game_file.store_line(json_string)

func load_game():
	var data
	if not FileAccess.file_exists(save_file):
		print("File do not exists")
		return null # Error! We don't have a save to load.
	
	# Load the file line by line and process that dictionary to restore
	# the object it represents.
	var save_game_file = FileAccess.open(save_file, FileAccess.READ)
	#return { "scores": { "packman": { "player_score": 1 } } }
	while save_game_file.get_position() < save_game_file.get_length():
		var json_string = save_game_file.get_line()

		# Creates the helper class to interact with JSON
		var json = JSON.new()

		# Check if there is any error while parsing the JSON string, skip in case of failure
		var parse_result = json.parse(json_string)
		if not parse_result == OK:
			print("JSON Parse Error: ", json.get_error_message(), " in ", json_string, " at line ", json.get_error_line())
			continue

		data = json.data
	return data
