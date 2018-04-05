extends Patch9Frame
#Este script se utiliza para lo relacionado con el libro de sumiistros, que 
#básicamente se limita a abrirlo y cerrarlo  
var suministros
var pedidos
var recetas
var compras
var precios
var mostrarSuministros = false

func _ready():
	hide()
	
	suministros = get_parent().get_node("Suministros")
	var cerrar = get_node("CerrarSuministros")
	pedidos = get_parent().get_node("Pedidos")
	recetas = get_parent().get_node("Recetas")
	compras = get_parent().get_node("Compras")
	precios = get_parent().get_node("Precios")
	
	if suministros:
		suministros.connect("pressed", self, "_mostrar_suministros")
	if cerrar:
		cerrar.connect("pressed", self, "_cerrar_suministros")
	pass

func _mostrar_suministros():
	mostrarSuministros = true
	show()
	get_parent().get_node("Dia").set_text("")
	recetas.hide()
	pedidos.hide()
	suministros.hide()
	compras.hide()
	precios.hide()
	pass

func _cerrar_suministros():
	mostrarSuministros = false
	hide()
	recetas.show()
	pedidos.show()
	suministros.show()
	compras.show()
	precios.show()
	pass


