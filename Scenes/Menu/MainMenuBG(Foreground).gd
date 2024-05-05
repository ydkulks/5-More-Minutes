extends ParallaxBackground

const scroll_speed = 20

func _process(delta):
	scroll_offset.x -= scroll_speed * delta
