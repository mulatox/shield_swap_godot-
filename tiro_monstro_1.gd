extends Area2D

@export var bullet_scene: PackedScene

const SPEED = 300.0
var direction = Vector2.ZERO

func _ready():
	direction = Vector2.RIGHT.rotated(rotation)
	modulate = Color(0.2, 0.5, 1.0)  # azul
	# ou modulate = Color(1, 0.2, 0.2) para vermelho

func _process(delta):
	position += direction * SPEED * delta
