extends Node
#Este script alimenta al menú principal del juego, y su funcionalidad se limita 
#únicamente a iniciar una nueva partida

func _ready():
	
	var nuevaPartida = get_node("NuevaPartida")
	var salir = get_node("Salir")
	
	if nuevaPartida:
		nuevaPartida.connect("pressed", self, "_nueva_partida")
	if salir:
		salir.connect("pressed", self, "_salir_juego")

func _nueva_partida():
	get_tree().change_scene("res://Scenes/Taberna.tscn")

func _salir_juego():
	get_tree().quit()