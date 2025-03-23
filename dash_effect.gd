extends Sprite2D

func _ready():
	modulate.a = 0.4  # Define o Alpha programaticamente
	$DestroyTimer.start()
	$DestroyTimer.timeout.connect(queue_free)
