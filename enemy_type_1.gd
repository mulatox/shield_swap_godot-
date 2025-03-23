extends "res://enemy.gd"

func _physics_process(delta):
	if not player_node: return
	print("Atualizando posicao!")
	print(player_node.global_position)
	var direction = (player_node.global_position - global_position).normalized()
	velocity = direction * speed
	move_and_slide()
