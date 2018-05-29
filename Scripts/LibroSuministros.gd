extends Patch9Frame
#Este script se utiliza para lo relacionado con el libro de sumiistros, que 
#básicamente se limita a abrirlo y cerrarlo  
var suministros
var mapa
var mostrarSuministros = false

func _ready():
	hide()
	
	suministros = get_parent().get_node("Suministros")
	var cerrar = get_node("CerrarSuministros")
	mapa = get_parent().get_parent()
	
	if suministros:
		suministros.connect("pressed", self, "_mostrar_suministros")
	if cerrar:
		cerrar.connect("pressed", self, "_cerrar_suministros")
	pass

func _mostrar_suministros():
	mostrarSuministros = true
	show()
	get_parent().get_node("Dia").set_text("")
	mapa.cerrar_Botones()
	pass

func _cerrar_suministros():
	mostrarSuministros = false
	hide()
	mapa.mostrar_botones()
	pass