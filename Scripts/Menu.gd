extends Node
#Este script alimenta al menú principal del juego, y su funcionalidad se limita 
#únicamente a iniciar una nueva partida

func _ready():
	
	var nuevaPartida = get_node("NuevaPartida")
	
	if nuevaPartida:
		nuevaPartida.connect("pressed", self, "_nueva_partida")

func _nueva_partida():
	get_tree().change_scene("res://Scenes/Taberna.tscn")