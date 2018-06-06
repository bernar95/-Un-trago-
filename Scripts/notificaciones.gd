extends PanelContainer
#Este script se utiliza para cerrar el panel de notificaciones en cuanto
#éste aparece
var timer = Timer.new()
var cerrar

func _ready():
	hide()
	
	cerrar = get_parent().get_node("Cerrar")
	cerrar.hide()
	
	timer.set_one_shot(true)
	self.add_child(timer)
	
	if cerrar:
		cerrar.connect("pressed", self, "_cerrar_notificaciones")
	pass
#Esta función gestiona la aparición de notificaciones en pantallas
func notificaciones(text):
	show()
	cerrar.show()
	get_node("Notificacion").set_text(text)
	timer.set_wait_time(10)
	timer.start()
	if "Has añadido" in text or text == "La comida se está cocinando":
		pass
	elif "El permiso de" in text or "Has ganado" in text or text == "La comida está lista":
		get_parent().get_parent().get_node("Sonidos/SamplePlayer2D").play("Bien", 9)
	else:
		get_parent().get_parent().get_node("Sonidos/SamplePlayer2D").play("Mal", 9)
	yield(timer, "timeout")
	hide()
	cerrar.hide()

func _cerrar_notificaciones():
	hide()
	get_parent().get_node("Cerrar").hide()
	timer.stop()
	pass