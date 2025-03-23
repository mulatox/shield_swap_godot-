extends Control

@onready var portrait = $Panel/Portrait
@onready var dialog_text = $Panel/DialogText
@onready var next_button = $Panel/Button

var dialog_queue = []  # Fila de falas
var is_typing = false  # Controle para efeito de máquina de escrever
var current_text = ""  # Texto atual sendo exibido
var typing_speed = 0.05  # Velocidade da digitação

func _ready():
	hide()  # Esconde a caixa de diálogo no início
	next_button.pressed.connect(_on_next_pressed)

func start_dialog(portrait_texture, dialog_lines):
	portrait.texture = portrait_texture  # Define a imagem do personagem
	dialog_queue = dialog_lines  # Armazena as falas
	show()
	show_next_dialog()

func show_next_dialog():
	if dialog_queue.is_empty():
		hide()  # Esconde a caixa de diálogo quando terminar
		return

	current_text = dialog_queue.pop_front()
	dialog_text.text = ""  # Limpa o texto anterior
	is_typing = true
	_type_text()

func _type_text():
	for i in range(current_text.length()):
		dialog_text.text += current_text[i]  # Adiciona uma letra por vez
		await get_tree().create_timer(typing_speed).timeout  # Aguarda um tempo
	is_typing = false

func _on_next_pressed():
	if is_typing:
		dialog_text.text = current_text  # Mostra o texto inteiro imediatamente
		is_typing = false
	else:
		show_next_dialog()  # Mostra a próxima fala
