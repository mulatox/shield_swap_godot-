
extends ParallaxBackground

var scroll_speed = Vector2(20, 0)

func _process(delta):
	scroll_offset += scroll_speed * delta
