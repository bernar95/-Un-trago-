extends Patch9Frame
#Este script se utiliza para lo relacionado con el libro de precios, que 
#básicamente se limita a abrirlo, cerrarlo y ocultar su contenido,
#ya que se irá desbloqueando conforme el jugador avance 
var precios
var recetas
var pedidos
var suministros
var compras
var mostrarPrecios = false

func _ready():
	hide()
	
	precios = get_parent().get_node("Precios")
	var cerrar = get_node("CerrarPrecios")
	recetas = get_parent().get_node("Recetas")
	pedidos = get_parent().get_node("Pedidos")
	suministros = get_parent().get_node("Suministros")
	compras = get_parent().get_node("Compras")
	
	get_node("Cerveza").hide()
	get_node("Pan").hide()
	get_node("Queso").hide()
	get_node("Carne").hide()
	get_node("Pescado").hide()
	get_node("Sopa").hide()
	get_node("Quebrantos").hide()
	get_node("Olla").hide()
	get_node("Estofado").hide()
	
	if precios:
		precios.connect("pressed", self, "_mostrar_precios")
	if cerrar:
		cerrar.connect("pressed", self, "_cerrar_precios")
	pass

func _mostrar_precios():
	mostrarPrecios = true
	show()
	get_parent().get_node("Dia").set_text("")
	precios.hide()
	recetas.hide()
	pedidos.hide()
	suministros.hide()
	compras.hide()
	pass

func _cerrar_precios():
	mostrarPrecios = false
	hide()
	precios.show()
	recetas.show()
	pedidos.show()
	suministros.show()
	compras.show()
	pass
	
