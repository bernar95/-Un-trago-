extends Patch9Frame

func _ready():
	hide()
	
	var suministros = get_parent().get_node("Suministros")
	var cerrar = get_parent().get_node("LibroSuministros/CerrarSuministros")
	
	if suministros:
		suministros.connect("pressed", self, "_mostrar_suministros")
	if cerrar:
		cerrar.connect("pressed", self, "_cerrar_suministros")
	pass

func _mostrar_suministros():
	show()
	pass

func _cerrar_suministros():
	hide()
	pass


