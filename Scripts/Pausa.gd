extends Panel
#Este script se utiliza para reanudar la partida(cerrar el menú de pausa)

var guardar
var cargar

func _ready():
	set_fixed_process(true)
	var reanudar = get_node("Reanudar")
	guardar = get_node("Guardar")
	cargar = get_node("Cargar")
	
	if reanudar:
		reanudar.connect("pressed", self, "_reanudar")
	if guardar:
		guardar.connect("pressed", self, "_guardar")
	if cargar:
		cargar.connect("pressed", self, "_cargar")
	pass

func _fixed_process(delta):
	if get_parent().get_parent().labelDia.is_visible():
		guardar.show()
		cargar.show()
	else:
		guardar.hide()
		cargar.hide()

func _reanudar():
	get_tree().set_pause(false)
	hide()

func _guardar():
	get_parent().guardar_partida()

func _cargar():
	get_parent().cargar_partida()