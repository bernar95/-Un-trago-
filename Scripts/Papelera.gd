extends Node

var notificaciones
var personaje

func _ready():
	notificaciones = get_parent().get_node("Hud/Notificaciones")
	personaje = get_parent().get_node("KinematicBody2D/Personaje")
	pass

func tirar_papelera():
	if personaje.get_child_count() > 0:
		for objeto in range(personaje.get_child_count()):
			var hijo = personaje.get_child(objeto)
			if hijo.get_filename() == global.spriteVino.get_path() or hijo.get_filename() == global.spriteCerveza.get_path():
				personaje.get_child(objeto).queue_free()
				get_parent().get_node("Sonidos/SamplePlayer2D").play("Verter", 1)
			else:
				notificaciones.notificaciones("Esto no se puede tirar aquí")
		global.instanciar_jarras("JarraVino")
		global.instanciar_jarras("JarraVino2")
		global.instanciar_jarras("JarraCerveza")
		global.instanciar_jarras("JarraCerveza2")
	else:
		notificaciones.notificaciones("No tienes nada que tirar")