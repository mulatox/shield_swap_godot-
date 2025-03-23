extends CharacterBody2D

@export var bullet_scene: PackedScene  # Referência ao tiro.tscn
@export var dash_effect_scene: PackedScene

const SPEED = 300.0
const DASH_SPEED = 800.0
const DASH_DURATION = 0.2
const DASH_COOLDOWN = 0.5


var is_dashing = false
var can_dash = true


func _input(event):
	if event.is_action_pressed("shoot"):  # Se pressionar para atirar
		shoot()
	if event.is_action_pressed("dash") and can_dash:
		dash()
		
func dash():
	is_dashing = true
	can_dash = false

	# Efeito: gerar várias cópias da nave durante o dash
	for i in range(5):
		show_dash_effect()
		await get_tree().create_timer(0.03).timeout

	is_dashing = false
	await get_tree().create_timer(DASH_COOLDOWN).timeout
	can_dash = true			
func show_dash_effect():
	print("Criando efeito de dash!")
	if dash_effect_scene:
		var ghost = dash_effect_scene.instantiate()
		ghost.global_position = global_position
		ghost.global_rotation = global_rotation
		ghost.texture = $Sprite2D.texture  # Certifique-se de ter um Sprite2D com a textura
		ghost.modulate.a = 0.4
		get_parent().add_child(ghost)
	else:
		print("dash_effect_scene não está definido!")	
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
		
	# Se não estiver movendo, usar a direção do mouse
	#if is_dashing and input_direction
	if is_dashing and input_direction == Vector2.ZERO:
		var to_mouse = (get_global_mouse_position() - global_position).normalized()
		input_direction = to_mouse	

	velocity = input_direction.normalized() * SPEED
	
	if is_dashing:
		velocity = input_direction * DASH_SPEED
	else:
		velocity = input_direction * SPEED

	
	move_and_slide()

	# Rotação para seguir o mouse
	var mouse_position = get_global_mouse_position()
	look_at(mouse_position)
	rotation += deg_to_rad(90) 
	
	
