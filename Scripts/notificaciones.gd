extends PanelContainer

func _ready():
	get_parent().get_node("Cerrar").hide()
	hide()
	
	var cerrar = get_parent().get_node("Cerrar")
	
	if cerrar:
		cerrar.connect("pressed", self, "_cerrar_notificaciones")
	pass

func _cerrar_notificaciones():
	hide()
	get_parent().get_node("Cerrar").hide()
	pass
