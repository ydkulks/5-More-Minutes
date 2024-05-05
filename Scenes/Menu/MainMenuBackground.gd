extends ParallaxBackground

const scroll_speed = 10

func _process(delta):
	scroll_offset.x -= scroll_speed * delta
