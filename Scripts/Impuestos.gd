extends Node

var beneficios
var impuestos
var continuar

var dinero

func _ready():
	var taberna = preload("res://Scenes/Taberna.tscn")
	var insTaberna = taberna.instance()
	dinero = insTaberna.get_node("Hud/Dinero").get_text()
	
	inicializarVariables(dinero)
	
	beneficios = int(get_node("Beneficios/Cantidad").get_text())
	impuestos = int(get_node("Impuestos/Cantidad").get_text())
	calcularImpuestos()
	
	continuar = get_node("Continuar")
	
	if continuar:
		continuar.connect("pressed", self, "_continuar")

	pass

func inicializarVariables(beneficios):
	get_node("Beneficios/Cantidad").set_text(beneficios)

func calcularImpuestos():
	beneficios -= impuestos
	get_node("Total/Cantidad").set_text(str(beneficios))

func _continuar():
	get_tree().change_scene("res://Scenes/Taberna.tscn")
