extends Node

func _ready():
	
	var nuevaPartida = get_node("NuevaPartida")
	
	if nuevaPartida:
		nuevaPartida.connect("pressed", self, "_nueva_partida")
	pass

func _nueva_partida():
	get_tree().change_scene("res://Scenes/Taberna.tscn")