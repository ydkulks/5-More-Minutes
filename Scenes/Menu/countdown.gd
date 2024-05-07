extends Panel

var time: float = 0.0
var minutes: int = 0
var seconds: int = 0

func _process(delta):
	time += delta
	@warning_ignore("narrowing_conversion")
	seconds = fmod(time,60)
	@warning_ignore("narrowing_conversion")
	minutes = fmod(time, 3600) / 60
	$Minutes.text = "%02d" % minutes
	$Seconds.text = "%02d" % seconds

func stop():
	set_process(false)
