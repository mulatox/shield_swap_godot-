extends Area2D

const SPEED = 800.0
var direction = Vector2.ZERO

func _ready():
	# Define a direção do tiro corrigindo o ângulo do sprite (caso esteja virado para cima)
	direction = (Vector2.RIGHT * SPEED).rotated(rotation - deg_to_rad(90))

func _process(delta):
	position += direction * delta  # Move o tiro corretamente

func _on_Bullet_body_entered(body):
	if body.has_method("take_damage"):  # Se o alvo pode receber dano
		body.take_damage()
	queue_free()  # Destroi o tiro na colisão
