extends Node2D

@onready var dialog_box = $DialogBox

func _ready():
	var portrait_texture = preload("res://portrait.png")  # Substitua pelo caminho da imagem
	var dialog_lines = [
		"Olá, bem-vindo ao jogo!",
		"Este é um sistema de diálogos.",
		"Você pode avançar clicando no botão."
	]
	dialog_box.start_dialog(portrait_texture, dialog_lines)
