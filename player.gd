extends CharacterBody2D

const SPEED = 300.0

@export var bullet_scene: PackedScene  # Referência ao tiro.tscn

func _input(event):
	if event.is_action_pressed("shoot"):  # Se pressionar para atirar
		shoot()

func shoot():
	if bullet_scene:
		var bullet = bullet_scene.instantiate()
		bullet.position = global_position  # O tiro nasce na posição do Player
		bullet.rotation = global_rotation  # O tiro segue a direção do Player
		get_parent().add_child(bullet)  # Adiciona o tiro na cena

func _ready():
	# Define a posição do Player no centro da tela
	position = get_viewport_rect().size / 2

func _process(delta):
	var input_direction = Vector2()

	# Movimento no WASD
	if Input.is_action_pressed("move_right"):
		input_direction.x += 1
	if Input.is_action_pressed("move_left"):
		input_direction.x -= 1
	if Input.is_action_pressed("move_down"):
		input_direction.y += 1
	if Input.is_action_pressed("move_up"):
		input_direction.y -= 1

	velocity = input_direction.normalized() * SPEED
	move_and_slide()

	# Rotação para seguir o mouse
	var mouse_position = get_global_mouse_position()
	look_at(mouse_position)
	rotation += deg_to_rad(90) 
