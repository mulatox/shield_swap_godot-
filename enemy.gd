extends CharacterBody2D

@export var player_path: NodePath  # Usa NodePath no Inspector
var player_node: Node = null       # Guarda a referência ao Player
@export var bullet_scene: PackedScene
@export var speed = 100.0
@export var shoot_interval = 2.0

@onready var sprite = $Sprite2D
@onready var shoot_timer = $ShootTimer

func _ready():
	if player_path:
		player_node = get_node(player_path)

	shoot_timer.wait_time = shoot_interval
	shoot_timer.timeout.connect(shoot)
	shoot_timer.start()

func _process(delta):
	if not player_path: return
	look_at(get_node(player_path).global_position)

func shoot():
	if bullet_scene and player_path:
		var bullet = bullet_scene.instantiate()
		bullet.position = global_position
		bullet.rotation = global_rotation
		get_parent().add_child(bullet)
