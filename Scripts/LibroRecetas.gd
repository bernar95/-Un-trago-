extends Patch9Frame
#Este script se utiliza para lo relacionado con el libro de recetas, que 
#básicamente se limita a abrirlo, cerrarlo y ocultar su contenido,
#ya que se irá desbloqueando conforme el jugador avance 
var recetas
var pedidos
var suministros
var compras
var precios
var mostrarRecetas = false

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
	precios = get_parent().get_node("Precios")
	
	if recetas:
		recetas.connect("pressed", self, "_mostrar_recetas")
	if cerrar:
		cerrar.connect("pressed", self, "_cerrar_recetas")
	pass

func _mostrar_recetas():
	mostrarRecetas = true
	show()
	get_parent().get_node("Dia").set_text("")
	recetas.hide()
	pedidos.hide()
	suministros.hide()
	compras.hide()
	precios.hide()
	pass

func _cerrar_recetas():
	mostrarRecetas = false
	hide()
	recetas.show()
	pedidos.show()
	suministros.show()
	compras.show()
	precios.show()
	pass
