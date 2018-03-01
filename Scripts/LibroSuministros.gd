extends Patch9Frame

var suministros
var pedidos
var recetas
var compras

func _ready():
	hide()
	
	suministros = get_parent().get_node("Suministros")
	var cerrar = get_node("CerrarSuministros")
	pedidos = get_parent().get_node("Pedidos")
	recetas = get_parent().get_node("Recetas")
	compras = get_parent().get_node("Compras")
	
	if suministros:
		suministros.connect("pressed", self, "_mostrar_suministros")
	if cerrar:
		cerrar.connect("pressed", self, "_cerrar_suministros")
	pass

func _mostrar_suministros():
	get_tree().set_pause(true)
	show()
	recetas.hide()
	pedidos.hide()
	suministros.hide()
	compras.hide()
	pass

func _cerrar_suministros():
	get_tree().set_pause(false)
	hide()
	recetas.show()
	pedidos.show()
	suministros.show()
	compras.show()
	pass


