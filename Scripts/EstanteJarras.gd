extends Sprite

var notificaciones
var personaje

func _ready():
	notificaciones = get_parent().get_parent().get_node("Hud/Notificaciones")
	personaje = get_parent().get_parent().get_node("KinematicBody2D/Personaje")
	pass

#Esta parte gestiona la interracción con la estantería de jarras, y
#básicamente lo que hace es que le aparezcan en las manos del 
#personaje las jarras, teniendo en cuenta si las manos están 
#ocupadas o no
func coger_jarra():
	if personaje.get_child_count() == 0:
		personaje.add_child(global.jarra)
		get_parent().get_parent().get_node("Sonidos/SamplePlayer2D").play("Coger_jarra", 4)
	elif personaje.get_child_count() == 1:
		get_parent().get_parent().get_node("Sonidos/SamplePlayer2D").play("Coger_jarra", 4)
		if personaje.get_child(0).get_pos() == global.mano_derecha:
			personaje.add_child(global.jarra2)
		else:
			personaje.add_child(global.jarra)
	else:
		notificaciones.notificaciones("Tienes las manos ocupadas")

func soltar_jarra():
	if personaje.get_child_count() == 0:
		notificaciones.notificaciones("No tienes nada que soltar")
	elif (personaje.get_child_count() == 1 or personaje.get_child_count() == 2) and personaje.get_child(0).get_filename() == global.spriteJarra.get_path():
		get_parent().get_parent().get_node("Sonidos/SamplePlayer2D").play("Coger_jarra", 4)
		if personaje.get_child(0).get_pos() == global.mano_derecha:
			personaje.get_child(0).free()
			global.instanciar_jarras("Jarra")
		else:
			personaje.get_child(0).free()
			global.instanciar_jarras("Jarra2")
	elif personaje.get_child_count() == 2 and personaje.get_child(1).get_filename() == global.spriteJarra.get_path():
		get_parent().get_parent().get_node("Sonidos/SamplePlayer2D").play("Coger_jarra", 4)
		if personaje.get_child(1).get_pos() == global.mano_derecha:
			personaje.get_child(1).free()
			global.instanciar_jarras("Jarra")
		else:
			personaje.get_child(1).free()
			global.instanciar_jarras("Jarra2")
	else:
		notificaciones.notificaciones("Esto no va aquí")