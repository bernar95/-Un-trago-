extends Patch9Frame

var recetas
var pedidos
var suministros
var compras

func _ready():
	hide()
	
	get_node("Chuletas").hide()
	get_node("Bacalao").hide()
	get_node("Quebrantos").hide()
	get_node("Sopa").hide()
	get_node("Olla").hide()
	get_node("Estofado").hide()
	
	recetas = get_parent().get_node("Recetas")
	var cerrar = get_node("CerrarRecetas")
	pedidos = get_parent().get_node("Pedidos")
	suministros = get_parent().get_node("Suministros")
	compras = get_parent().get_node("Compras")
	
	if recetas:
		recetas.connect("pressed", self, "_mostrar_recetas")
	if cerrar:
		cerrar.connect("pressed", self, "_cerrar_recetas")
	pass

func _mostrar_recetas():
	get_tree().set_pause(true)
	show()
	recetas.hide()
	pedidos.hide()
	suministros.hide()
	compras.hide()
	
	pass

func _cerrar_recetas():
	get_tree().set_pause(false)
	hide()
	recetas.show()
	pedidos.show()
	suministros.show()
	compras.show()
	pass
