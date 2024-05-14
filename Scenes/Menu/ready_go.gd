extends Control

var first_time:bool = true

func reset():
	visible = false
	get_node("Message").text = "Ready!"
	get_node("Timer").stop()

func _on_timer_timeout():
	if first_time:
		get_node("Message").text = "Go!"
		first_time = false
	else:
		first_time = true #reset
		reset()
		get_tree().paused = false

func _on_visibility_changed():
	get_node("Timer").start(1.0)
	#print(get_node("Timer").get_wait_time())
