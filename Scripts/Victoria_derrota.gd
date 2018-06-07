extends Node

func _ready():
	var menu = get_node("Menu")
	var salir = get_node("Salir")
	
	if menu:
		menu.connect("pressed", self, "_menu_principal")
	if salir:
		salir.connect("pressed", self, "_salir_juego")
	pass

func _menu_principal():
	get_tree().change_scene("res://Scenes/Menu.tscn")

func _salir_juego():
	get_tree().quit()
