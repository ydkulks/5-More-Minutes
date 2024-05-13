extends Node

var save_file = "user://5MoreMinutes.save"

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
