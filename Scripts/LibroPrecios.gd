extends Patch9Frame
#Este script se utiliza para lo relacionado con el libro de precios, que 
#básicamente se limita a abrirlo, cerrarlo y ocultar su contenido,
#ya que se irá desbloqueando conforme el jugador avance 
var precios
var mostrarPrecios = false
var mapa

func _ready():
	hide()
	
	precios = get_parent().get_node("Precios")
	var cerrar = get_node("CerrarPrecios")
	mapa = get_parent().get_parent()
	
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
	mapa.cerrar_Botones()
	pass

func _cerrar_precios():
	mostrarPrecios = false
	hide()
	mapa.mostrar_botones()
	pass