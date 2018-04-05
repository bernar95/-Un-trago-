extends Panel

var botonPlatoDia
var desplegable
var plato_seleccionado = ""

func _ready():
	hide()
	desplegable = get_node("Platos")
	cargarPlatos()
	botonPlatoDia = get_parent().get_node("PlatoDia")
	botonPlatoDia.hide()
	var botonAtras = get_node("Atras")
	desplegable.connect("item_selected", self, "_seleccionar_plato")
	if botonPlatoDia:
		botonPlatoDia.connect("pressed", self, "_abrir_menu")
	if botonAtras:
		botonAtras.connect("pressed", self, "_cerrar_menu")
	pass

func _abrir_menu():
	show()

func _cerrar_menu():
	hide()

func cargarPlatos():
	desplegable.add_item("Seleccionar plato del día")
	desplegable.add_item("Chuletas")
	desplegable.add_item("Bacalao")

func _seleccionar_plato(id):
	if str(desplegable.get_item_text(id)) == "Chuletas":
		plato_seleccionado = "res://Scenes/carneCocinada.tscn"
	elif str(desplegable.get_item_text(id)) == "Bacalao":
		plato_seleccionado = "res://Scenes/pescadoCocinado.tscn"
	elif str(desplegable.get_item_text(id)) == "Quebrantos":
		plato_seleccionado = "res://Scenes/quebrantos.tscn"
	elif str(desplegable.get_item_text(id)) == "Sopa":
		plato_seleccionado = "res://Scenes/sopa.tscn"
	elif str(desplegable.get_item_text(id)) == "Olla podrida":
		plato_seleccionado = "res://Scenes/olla.tscn"
	elif str(desplegable.get_item_text(id)) == "Estofado":
		plato_seleccionado = "res://Scenes/estofado.tscn"
	global.plato_hoy = plato_seleccionado
	hide()
	botonPlatoDia.hide()
	
	
	

