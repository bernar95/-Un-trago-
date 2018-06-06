extends Node

var personaje
var notificaciones
var tiempo_verter = Timer.new()
var servir = false

func _ready():
	personaje = get_parent().get_parent().get_node("KinematicBody2D/Personaje")
	notificaciones = get_parent().get_parent().get_node("Hud/Notificaciones")
	get_node("Barril1").hide()
	tiempo_verter.set_one_shot(true)
	self.add_child(tiempo_verter)
	pass
#Esta parte gestiona la interracción con los barriles de vino y cerveza, y
#lo que hace es que sustituya las jarras vacías por jarras llenas,
#teniendo en cuenta si tienes stock del líquido en cuestión, si lo que
#tienes en la mano es una jarra, o si ya tienes las jarras llenas
func interaccion_barril(result):
	if personaje.get_child_count() == 0 or personaje.get_child_count() == 1 and personaje.get_child(0).get_filename() != global.spriteJarra.get_path() and personaje.get_child(0).get_filename() != global.spriteCerveza.get_path() and personaje.get_child(0).get_filename() != global.spriteVino.get_path() :
		notificaciones.notificaciones("Necesitas una jarra vacía")
	elif personaje.get_child_count() == 1:
		if personaje.get_child(0).get_filename() == global.spriteCerveza.get_path() or personaje.get_child(0).get_filename() == global.spriteVino.get_path():
			notificaciones.notificaciones("La jarra ya está llena")
		elif personaje.get_child(0).get_filename() == global.spriteJarra.get_path():
			if get_parent().get_parent().get_node("Hud/Container").stock_cerveza == 0 and result[0].collider.has_node("BarrilCervezaInteraccion"):
				notificaciones.notificaciones("No tienes cerveza")
			elif get_parent().get_parent().get_node("Hud/Container").stock_vino == 0 and result[0].collider.has_node("BarrilVinoInteraccion"):
				notificaciones.notificaciones("No tienes vino")
			elif get_parent().get_parent().get_node("Hud/Container").stock_cerveza > 0 and result[0].collider.has_node("BarrilCervezaInteraccion"):
				if personaje.get_child(0).get_pos() == global.mano_derecha:
					rellenarJarra(global.cerveza, "0")
					global.instanciar_jarras("Jarra")
				else:
					rellenarJarra(global.cerveza2, "0")
					global.instanciar_jarras("Jarra2")
			elif get_parent().get_parent().get_node("Hud/Container").stock_vino > 0 and result[0].collider.has_node("BarrilVinoInteraccion"):
				if personaje.get_child(0).get_pos() == global.mano_derecha:
					rellenarJarra(global.vino, "0")
					global.instanciar_jarras("Jarra")
				else:
					rellenarJarra(global.vino2, "0")
					global.instanciar_jarras("Jarra2")
	elif personaje.get_child_count() == 2:
		if personaje.get_child(0).get_filename() == global.spriteJarra.get_path() and personaje.get_child(1).get_filename() == global.spriteJarra.get_path():
			if get_parent().get_parent().get_node("Hud/Container").stock_cerveza == 0 and result[0].collider.has_node("BarrilCervezaInteraccion"):
				notificaciones.notificaciones("No tienes cerveza")
			elif get_parent().get_parent().get_node("Hud/Container").stock_vino == 0 and result[0].collider.has_node("BarrilVinoInteraccion"):
				notificaciones.notificaciones("No tienes vino")
			elif get_parent().get_parent().get_node("Hud/Container").stock_cerveza == 1 and result[0].collider.has_node("BarrilCervezaInteraccion"):
				if personaje.get_child(0).get_pos() == global.mano_derecha:
					rellenarJarra(global.cerveza, "0")
					global.instanciar_jarras("Jarra")
				else:
					rellenarJarra(global.cerveza2, "0")
					global.instanciar_jarras("Jarra2")
				notificaciones.notificaciones("No tienes cerveza para ambas jarras")
			elif get_parent().get_parent().get_node("Hud/Container").stock_vino == 1 and result[0].collider.has_node("BarrilVinoInteraccion"):
				if personaje.get_child(0).get_pos() == global.mano_derecha:
					rellenarJarra(global.vino, "0")
					global.instanciar_jarras("Jarra")
				else:
					rellenarJarra(global.vino2, "0")
					global.instanciar_jarras("Jarra2")
				notificaciones.notificaciones("No tienes vino para ambas jarras")
			elif get_parent().get_parent().get_node("Hud/Container").stock_cerveza >= 2 and result[0].collider.has_node("BarrilCervezaInteraccion"):
				rellenarJarra(global.cerveza, "0")
				rellenarJarra(global.cerveza2, "0")
				global.instanciar_jarras("Jarra")
				global.instanciar_jarras("Jarra2")
			elif get_parent().get_parent().get_node("Hud/Container").stock_vino >= 2 and result[0].collider.has_node("BarrilVinoInteraccion"):
				rellenarJarra(global.vino, "0")
				rellenarJarra(global.vino2, "0")
				global.instanciar_jarras("Jarra")
				global.instanciar_jarras("Jarra2")
		elif personaje.get_child(0).get_filename() == global.spriteCerveza.get_path() and personaje.get_child(1).get_filename() == global.spriteCerveza.get_path() or personaje.get_child(0).get_filename() == global.spriteVino.get_path() and personaje.get_child(1).get_filename() == global.spriteVino.get_path() or personaje.get_child(0).get_filename() == global.spriteVino.get_path() and personaje.get_child(1).get_filename() == global.spriteCerveza.get_path() or personaje.get_child(0).get_filename() == global.spriteCerveza.get_path() and personaje.get_child(1).get_filename() == global.spriteVino.get_path():
			notificaciones.notificaciones("Tienes las jarras llenas")
		elif personaje.get_child(0).get_filename() != global.spriteJarra.get_path() and personaje.get_child(1).get_filename() != global.spriteJarra.get_path():
			notificaciones.notificaciones("Necesitas una jarra vacía")
		else:
			if get_parent().get_parent().get_node("Hud/Container").stock_cerveza > 0 and result[0].collider.has_node("BarrilCervezaInteraccion"):
				if personaje.get_child(0).get_filename() == global.spriteJarra.get_path():
					if personaje.get_child(0).get_pos() == global.mano_derecha:
						rellenarJarra(global.cerveza, "0")
						global.instanciar_jarras("Jarra")
					else:
						rellenarJarra(global.cerveza2, "0")
						global.instanciar_jarras("Jarra2")
				elif personaje.get_child(1).get_filename() == global.spriteJarra.get_path():
					if personaje.get_child(1).get_pos() == global.mano_derecha:
						rellenarJarra(global.cerveza, "1")
						global.instanciar_jarras("Jarra")
					else:
						rellenarJarra(global.cerveza2, "1")
						global.instanciar_jarras("Jarra2")
			elif get_parent().get_parent().get_node("Hud/Container").stock_vino > 0 and result[0].collider.has_node("BarrilVinoInteraccion"):
				if personaje.get_child(0).get_filename() == global.spriteJarra.get_path():
					if personaje.get_child(0).get_pos() == global.mano_derecha:
						rellenarJarra(global.vino, "0")
						global.instanciar_jarras("Jarra")
					else:
						rellenarJarra(global.vino2, "0")
						global.instanciar_jarras("Jarra2")
				elif personaje.get_child(1).get_filename() == global.spriteJarra.get_path():
					if personaje.get_child(1).get_pos() == global.mano_derecha:
						rellenarJarra(global.vino, "1")
						global.instanciar_jarras("Jarra")
					else:
						rellenarJarra(global.vino2, "1")
						global.instanciar_jarras("Jarra2")
			elif get_parent().get_parent().get_node("Hud/Container").stock_cerveza == 0 and result[0].collider.has_node("BarrilCervezaInteraccion"):
				notificaciones.notificaciones("No tienes cerveza")
			elif get_parent().get_parent().get_node("Hud/Container").stock_vino == 0 and result[0].collider.has_node("BarrilVinoInteraccion"):
				notificaciones.notificaciones("No tienes vino")
#Esta función sirve para rellenar las jarras, restando una unidad del 
#stock de la bebida correspondiente 
func rellenarJarra(bebida, hijo):
	if hijo == "0":
		personaje.get_child(0).free()
	elif hijo == "1":
		personaje.get_child(1).free()
	personaje.add_child(bebida)
	tiempo_verter.set_wait_time(1.5)
	tiempo_verter.start()
	servir = true
	get_parent().get_parent().get_node("Sonidos/SamplePlayer2D").play("Rellenar_jarra", 1)
	yield(tiempo_verter, "timeout")
	servir = false
	get_parent().get_parent().get_node("Sonidos/SamplePlayer2D").stop_voice(1)
	

	if bebida == global.cerveza or bebida == global.cerveza2:
		get_parent().get_parent().get_node("Hud/Container").stock_cerveza -= 1
		var text = str(get_parent().get_parent().get_node("Hud/Container").stock_cerveza) + "/90"
		get_parent().get_parent().get_node("Hud/LibroSuministros/ContainerCerveza/StockCerveza").set_text(text)
	elif bebida == global.vino or bebida == global.vino2:
		get_parent().get_parent().get_node("Hud/Container").stock_vino -= 1
		var text = str(get_parent().get_parent().get_node("Hud/Container").stock_vino) + "/90"
		get_parent().get_parent().get_node("Hud/LibroSuministros/ContainerVino/StockVino").set_text(text)