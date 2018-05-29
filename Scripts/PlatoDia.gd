extends Panel
#Este script se utiliza para todo lo relacionado con el plato del día
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
#Esta función se utiliza para cargar en el desplegable los platos iniciales
func cargarPlatos():
	desplegable.add_item("Seleccionar plato del día")
	desplegable.add_item("Chuletas")
	desplegable.add_item("Bacalao")
#Esta función se utiliza para instanciar la variable global llamada
#"plato_hoy" con el valor seleccionado del desplegable
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