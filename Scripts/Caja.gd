extends Node

var personaje
var notificaciones

var carne = false
var pescado = false
var verduras = false
var patatas = false
var huevos = false
var pan = false
var queso = false

func _ready():
	set_fixed_process(true)
	notificaciones = get_parent().get_parent().get_node("Hud/Notificaciones")
	personaje = get_parent().get_parent().get_node("KinematicBody2D/Personaje")
	get_node("CajaCarne").hide()
	get_node("CajaPescado").hide()
	get_node("CajaVerduras").hide()
	get_node("CajaPatatas").hide()
	get_node("CajaPan").hide()
	get_node("CajaQueso").hide()
	get_node("CajaHuevos").hide()
	pass

func _fixed_process(delta):
	if get_parent().get_parent().get_node("Hud/Container").stock_carne > 0 and carne == false:
		global.carne3 = global.spriteCarne.instance()
		global.carne3.set_pos(Vector2(290, 42))
		get_parent().get_parent().get_node("BarraDetras/Alimentos/Carne").add_child(global.carne3)
		carne = true
	elif get_parent().get_parent().get_node("Hud/Container").stock_pescado > 0 and pescado == false:
		global.pescado3 = global.spritePescado.instance()
		global.pescado3.set_pos(Vector2(640, 42))
		get_parent().get_parent().get_node("BarraDetras/Alimentos/Pescado").add_child(global.pescado3)
		pescado = true
	elif get_parent().get_parent().get_node("Hud/Container").stock_verduras > 0 and verduras == false:
		global.verdura3 = global.spriteVerduras.instance()
		global.verdura3.set_pos(Vector2(704, 42))
		get_parent().get_parent().get_node("BarraDetras/Alimentos/Verduras").add_child(global.verdura3)
		verduras = true
	elif get_parent().get_parent().get_node("Hud/Container").stock_patatas > 0 and patatas == false:
		global.patata3 = global.spritePatatas.instance()
		global.patata3.set_pos(Vector2(736, 42))
		get_parent().get_parent().get_node("BarraDetras/Alimentos/Patatas").add_child(global.patata3)
		patatas = true
	elif get_parent().get_parent().get_node("Hud/Container").stock_pan > 0 and pan == false:
		global.pan3 = global.spritePan.instance()
		global.pan3.set_pos(Vector2(512, 26))
		get_parent().get_parent().get_node("BarraDetras/Alimentos/Pan").add_child(global.pan3)
		pan = true
	elif get_parent().get_parent().get_node("Hud/Container").stock_queso > 0 and queso == false:
		global.queso3 = global.spriteQueso.instance()
		global.queso3.set_pos(Vector2(672, 42))
		get_parent().get_parent().get_node("BarraDetras/Alimentos/Queso").add_child(global.queso3)
		queso = true
	elif get_parent().get_parent().get_node("Hud/Container").stock_huevos > 0 and huevos == false:
		global.huevo3 = global.spriteHuevos.instance()
		global.huevo3.set_pos(Vector2(544, 26))
		get_parent().get_parent().get_node("BarraDetras/Alimentos/Huevos").add_child(global.huevo3)
		huevos = true
#Esta parte gestiona la interracción con las cajas de alimentos, y lo que
#hace es que le aparezcan en las manos del personaje los alimentos, 
#teniendo en cuenta si las manos están ocupadas o no y si tienes stock
#del alimento en cuestión
func interaccion_caja(result):
	if personaje.get_child_count() == 0 or personaje.get_child_count() == 1:
		if get_parent().get_parent().get_node("Hud/Container").stock_carne == 0 and result[0].collider.has_node("CajaCarneInteraccion"):
			notificaciones.notificaciones("No tienes carne")
		elif get_parent().get_parent().get_node("Hud/Container").stock_pescado == 0 and result[0].collider.has_node("CajaPescadoInteraccion"):
			notificaciones.notificaciones("No tienes pescado")
		elif get_parent().get_parent().get_node("Hud/Container").stock_verduras == 0 and result[0].collider.has_node("CajaVerdurasInteraccion"):
			notificaciones.notificaciones("No tienes verduras")
		elif get_parent().get_parent().get_node("Hud/Container").stock_patatas == 0 and result[0].collider.has_node("CajaPatatasInteraccion"):
			notificaciones.notificaciones("No tienes patatas")
		elif get_parent().get_parent().get_node("Hud/Container").stock_pan == 0 and result[0].collider.has_node("CajaPanInteraccion"):
			notificaciones.notificaciones("No tienes pan")
		elif get_parent().get_parent().get_node("Hud/Container").stock_queso == 0 and result[0].collider.has_node("CajaQuesoInteraccion"):
			notificaciones.notificaciones("No tienes queso")
		elif get_parent().get_parent().get_node("Hud/Container").stock_huevos == 0 and result[0].collider.has_node("CajaHuevosInteraccion"):
			notificaciones.notificaciones("No tienes huevos")
	if personaje.get_child_count() == 0:
		if get_parent().get_parent().get_node("Hud/Container").stock_carne > 0 and result[0].collider.has_node("CajaCarneInteraccion"):
			cogerComida(global.carne)
			if get_parent().get_parent().get_node("Hud/Container").stock_carne == 0:
				eliminar_sprites(get_parent().get_parent().get_node("BarraDetras/Alimentos/Carne"))
				carne = false
		elif get_parent().get_parent().get_node("Hud/Container").stock_pescado > 0 and result[0].collider.has_node("CajaPescadoInteraccion"):
			cogerComida(global.pescado)
			if get_parent().get_parent().get_node("Hud/Container").stock_pescado == 0:
				eliminar_sprites(get_parent().get_parent().get_node("BarraDetras/Alimentos/Pescado"))
				pescado = false
		elif get_parent().get_parent().get_node("Hud/Container").stock_verduras > 0 and result[0].collider.has_node("CajaVerdurasInteraccion"):
			cogerComida(global.verdura)
			if get_parent().get_parent().get_node("Hud/Container").stock_verduras == 0:
				eliminar_sprites(get_parent().get_parent().get_node("BarraDetras/Alimentos/Verduras"))
				verduras = false
		elif get_parent().get_parent().get_node("Hud/Container").stock_patatas > 0 and result[0].collider.has_node("CajaPatatasInteraccion"):
			cogerComida(global.patata)
			if get_parent().get_parent().get_node("Hud/Container").stock_patatas == 0:
				eliminar_sprites(get_parent().get_parent().get_node("BarraDetras/Alimentos/Patatas"))
				patatas = false
		elif get_parent().get_parent().get_node("Hud/Container").stock_pan > 0 and result[0].collider.has_node("CajaPanInteraccion"):
			cogerComida(global.pan)
			if get_parent().get_parent().get_node("Hud/Container").stock_pan == 0:
				eliminar_sprites(get_parent().get_parent().get_node("BarraDetras/Alimentos/Pan"))
				pan = false
		elif get_parent().get_parent().get_node("Hud/Container").stock_queso > 0 and result[0].collider.has_node("CajaQuesoInteraccion"):
			cogerComida(global.queso)
			if get_parent().get_parent().get_node("Hud/Container").stock_queso == 0:
				eliminar_sprites(get_parent().get_parent().get_node("BarraDetras/Alimentos/Queso"))
				queso = false
		elif get_parent().get_parent().get_node("Hud/Container").stock_huevos > 0 and result[0].collider.has_node("CajaHuevosInteraccion"):
			cogerComida(global.huevo)
			if get_parent().get_parent().get_node("Hud/Container").stock_huevos == 0:
				eliminar_sprites(get_parent().get_parent().get_node("BarraDetras/Alimentos/Huevos"))
				huevos = false
	elif personaje.get_child_count() == 1:
		if get_parent().get_parent().get_node("Hud/Container").stock_carne > 0 and result[0].collider.has_node("CajaCarneInteraccion"):
			if personaje.get_child(0).get_pos() == global.mano_derecha:
				cogerComida(global.carne2)
			else:
				cogerComida(global.carne)
			if get_parent().get_parent().get_node("Hud/Container").stock_carne == 0:
				eliminar_sprites(get_parent().get_parent().get_node("BarraDetras/Alimentos/Carne"))
				carne = false
		elif get_parent().get_parent().get_node("Hud/Container").stock_pescado > 0 and result[0].collider.has_node("CajaPescadoInteraccion"):
			if personaje.get_child(0).get_pos() == global.mano_derecha:
				cogerComida(global.pescado2)
			else:
				cogerComida(global.pescado)
			if get_parent().get_parent().get_node("Hud/Container").stock_pescado == 0:
				eliminar_sprites(get_parent().get_parent().get_node("BarraDetras/Alimentos/Pescado"))
				pescado = false
		elif get_parent().get_parent().get_node("Hud/Container").stock_verduras > 0 and result[0].collider.has_node("CajaVerdurasInteraccion"):
			if personaje.get_child(0).get_pos() == global.mano_derecha:
				cogerComida(global.verdura2)
			else:
				cogerComida(global.verdura)
			if get_parent().get_parent().get_node("Hud/Container").stock_verduras == 0:
				eliminar_sprites(get_parent().get_parent().get_node("BarraDetras/Alimentos/Verduras"))
				verduras = false
		elif get_parent().get_parent().get_node("Hud/Container").stock_patatas > 0 and result[0].collider.has_node("CajaPatatasInteraccion"):
			if personaje.get_child(0).get_pos() == global.mano_derecha:
				cogerComida(global.patata2)
			else:
				cogerComida(global.patata)
			if get_parent().get_parent().get_node("Hud/Container").stock_patatas == 0:
				eliminar_sprites(get_parent().get_parent().get_node("BarraDetras/Alimentos/Patatas"))
				patatas = false
		elif get_parent().get_parent().get_node("Hud/Container").stock_pan > 0 and result[0].collider.has_node("CajaPanInteraccion"):
			if personaje.get_child(0).get_pos() == global.mano_derecha:
				cogerComida(global.pan2)
			else:
				cogerComida(global.pan)
			if get_parent().get_parent().get_node("Hud/Container").stock_pan == 0:
				eliminar_sprites(get_parent().get_parent().get_node("BarraDetras/Alimentos/Pan"))
				pan = false
		elif get_parent().get_parent().get_node("Hud/Container").stock_queso > 0 and result[0].collider.has_node("CajaQuesoInteraccion"):
			if personaje.get_child(0).get_pos() == global.mano_derecha:
				cogerComida(global.queso2)
			else:
				cogerComida(global.queso)
			if get_parent().get_parent().get_node("Hud/Container").stock_queso == 0:
				eliminar_sprites(get_parent().get_parent().get_node("BarraDetras/Alimentos/Queso"))
				queso = false
		elif get_parent().get_parent().get_node("Hud/Container").stock_huevos > 0 and result[0].collider.has_node("CajaHuevosInteraccion"):
			if personaje.get_child(0).get_pos() == global.mano_derecha:
				cogerComida(global.huevo2)
			else:
				cogerComida(global.huevo)
			if get_parent().get_parent().get_node("Hud/Container").stock_huevos == 0:
				eliminar_sprites(get_parent().get_parent().get_node("BarraDetras/Alimentos/Huevos"))
				huevos = false
	elif personaje.get_child_count() == 2:
		notificaciones.notificaciones("Tienes las manos ocupadas")

func dejar_alimento(result):
	if personaje.get_child_count() == 0:
		notificaciones.notificaciones("No tienes nada que soltar")
	elif (personaje.get_child_count() == 1 or personaje.get_child_count() == 2) and result[0].collider.has_node("CajaCarneInteraccion") and personaje.get_child(0).get_filename() == global.spriteCarne.get_path():
		if personaje.get_child(0).get_pos() == global.mano_derecha:
			dejarComida("Carne", "0")
			global.instanciar_ingredientes(global.carne)
		else:
			dejarComida("Carne", "0")
			global.instanciar_ingredientes(global.carne2)
	elif (personaje.get_child_count() == 1 or personaje.get_child_count() == 2) and result[0].collider.has_node("CajaPescadoInteraccion") and personaje.get_child(0).get_filename() == global.spritePescado.get_path():
		if personaje.get_child(0).get_pos() == global.mano_derecha:
			dejarComida("Pescado", "0")
			global.instanciar_ingredientes(global.pescado)
		else:
			dejarComida("Pescado", "0")
			global.instanciar_ingredientes(global.pescado2)
	elif (personaje.get_child_count() == 1 or personaje.get_child_count() == 2) and result[0].collider.has_node("CajaVerdurasInteraccion") and personaje.get_child(0).get_filename() == global.spriteVerduras.get_path():
		if personaje.get_child(0).get_pos() == global.mano_derecha:
			dejarComida("Verdura", "0")
			global.instanciar_ingredientes(global.verdura)
		else:
			dejarComida("Verdura", "0")
			global.instanciar_ingredientes(global.verdura2)
	elif (personaje.get_child_count() == 1 or personaje.get_child_count() == 2) and result[0].collider.has_node("CajaPatatasInteraccion") and personaje.get_child(0).get_filename() == global.spritePatatas.get_path():
		if personaje.get_child(0).get_pos() == global.mano_derecha:
			dejarComida("Patata", "0")
			global.instanciar_ingredientes(global.patata)
		else:
			dejarComida("Patata", "0")
			global.instanciar_ingredientes(global.patata2)
	elif (personaje.get_child_count() == 1 or personaje.get_child_count() == 2) and result[0].collider.has_node("CajaPanInteraccion") and personaje.get_child(0).get_filename() == global.spritePan.get_path():
		if personaje.get_child(0).get_pos() == global.mano_derecha:
			dejarComida("Pan", "0")
			global.instanciar_ingredientes(global.pan)
		else:
			dejarComida("Pan", "0")
			global.instanciar_ingredientes(global.pan2)
	elif (personaje.get_child_count() == 1 or personaje.get_child_count() == 2) and result[0].collider.has_node("CajaQuesoInteraccion") and personaje.get_child(0).get_filename() == global.spriteQueso.get_path():
		if personaje.get_child(0).get_pos() == global.mano_derecha:
			dejarComida("Queso", "0")
			global.instanciar_ingredientes(global.queso)
		else:
			dejarComida("Queso", "0")
			global.instanciar_ingredientes(global.queso2)
	elif (personaje.get_child_count() == 1 or personaje.get_child_count() == 2) and result[0].collider.has_node("CajaHuevosInteraccion") and personaje.get_child(0).get_filename() == global.spriteHuevos.get_path():
		if personaje.get_child(0).get_pos() == global.mano_derecha:
			dejarComida("Huevo", "0")
			global.instanciar_ingredientes(global.huevo)
		else:
			dejarComida("Huevo", "0")
			global.instanciar_ingredientes(global.huevo2)
	elif personaje.get_child_count() == 2 and result[0].collider.has_node("CajaCarneInteraccion") and personaje.get_child(1).get_filename() == global.spriteCarne.get_path():
		if personaje.get_child(1).get_pos() == global.mano_derecha:
			dejarComida("Carne", "1")
			global.instanciar_ingredientes(global.carne)
		else:
			dejarComida("Carne", "1")
			global.instanciar_ingredientes(global.carne2)
	elif personaje.get_child_count() == 2 and result[0].collider.has_node("CajaPescadoInteraccion") and personaje.get_child(1).get_filename() == global.spritePescado.get_path():
		if personaje.get_child(1).get_pos() == global.mano_derecha:
			dejarComida("Pescado", "1")
			global.instanciar_ingredientes(global.pescado)
		else:
			dejarComida("Pescado", "1")
			global.instanciar_ingredientes(global.pescado2)
	elif personaje.get_child_count() == 2 and result[0].collider.has_node("CajaVerdurasInteraccion") and personaje.get_child(1).get_filename() == global.spriteVerduras.get_path():
		if personaje.get_child(1).get_pos() == global.mano_derecha:
			dejarComida("Verdura", "1")
			global.instanciar_ingredientes(global.verdura)
		else:
			dejarComida("Verdura", "1")
			global.instanciar_ingredientes(global.verdura2)
	elif personaje.get_child_count() == 2 and result[0].collider.has_node("CajaPatatasInteraccion") and personaje.get_child(1).get_filename() == global.spritePatatas.get_path():
		if personaje.get_child(1).get_pos() == global.mano_derecha:
			dejarComida("Patata", "1")
			global.instanciar_ingredientes(global.patata)
		else:
			dejarComida("Patata", "1")
			global.instanciar_ingredientes(global.patata2)
	elif personaje.get_child_count() == 2 and result[0].collider.has_node("CajaPanInteraccion") and personaje.get_child(1).get_filename() == global.spritePan.get_path():
		if personaje.get_child(1).get_pos() == global.mano_derecha:
			dejarComida("Pan", "1")
			global.instanciar_ingredientes(global.pan)
		else:
			dejarComida("Pan", "1")
			global.instanciar_ingredientes(global.pan2)
	elif personaje.get_child_count() == 2 and result[0].collider.has_node("CajaQuesoInteraccion") and personaje.get_child(1).get_filename() == global.spriteQueso.get_path():
		if personaje.get_child(1).get_pos() == global.mano_derecha:
			dejarComida("Queso", "1")
			global.instanciar_ingredientes(global.queso)
		else:
			dejarComida("Queso", "1")
			global.instanciar_ingredientes(global.queso2)
	elif personaje.get_child_count() == 2 and result[0].collider.has_node("CajaHuevosInteraccion") and personaje.get_child(1).get_filename() == global.spriteHuevos.get_path():
		if personaje.get_child(1).get_pos() == global.mano_derecha:
			dejarComida("Huevo", "1")
			global.instanciar_ingredientes(global.huevo)
		else:
			dejarComida("Huevo", "1")
			global.instanciar_ingredientes(global.huevo2)
	else:
		notificaciones.notificaciones("Esto no va aquí")

#Esta función sirve para coger la comida de las cajas
func cogerComida(comida):
	personaje.add_child(comida)
	if comida == global.carne or comida == global.carne2:
		get_parent().get_parent().get_node("Sonidos/SamplePlayer2D").play("Coger_2", 1)
		get_parent().get_parent().get_node("Hud/Container").stock_carne -= 1
		var text = str(get_parent().get_parent().get_node("Hud/Container").stock_carne) + "/10"
		get_parent().get_parent().get_node("Hud/LibroSuministros/ContainerCarne/StockCarne").set_text(text)
	elif comida == global.pescado or comida == global.pescado2:
		get_parent().get_parent().get_node("Sonidos/SamplePlayer2D").play("Coger_2", 1)
		get_parent().get_parent().get_node("Hud/Container").stock_pescado -= 1
		var text = str(get_parent().get_parent().get_node("Hud/Container").stock_pescado) + "/10"
		get_parent().get_parent().get_node("Hud/LibroSuministros/ContainerPescado/StockPescado").set_text(text)
	elif comida == global.verdura or comida == global.verdura2:
		get_parent().get_parent().get_node("Sonidos/SamplePlayer2D").play("Coger", 1)
		get_parent().get_parent().get_node("Hud/Container").stock_verduras -= 1
		var text = str(get_parent().get_parent().get_node("Hud/Container").stock_verduras) + "/60"
		get_parent().get_parent().get_node("Hud/LibroSuministros/ContainerVerduras/StockVerduras").set_text(text)
	elif comida == global.patata or comida == global.patata2:
		get_parent().get_parent().get_node("Sonidos/SamplePlayer2D").play("Coger", 1)
		get_parent().get_parent().get_node("Hud/Container").stock_patatas -= 1
		var text = str(get_parent().get_parent().get_node("Hud/Container").stock_patatas) + "/80"
		get_parent().get_parent().get_node("Hud/LibroSuministros/ContainerPatatas/StockPatatas").set_text(text)
	elif comida == global.pan or comida == global.pan2:
		get_parent().get_parent().get_node("Sonidos/SamplePlayer2D").play("Crujir", 1)
		get_parent().get_parent().get_node("Hud/Container").stock_pan -= 1
		var text = str(get_parent().get_parent().get_node("Hud/Container").stock_pan) + "/20"
		get_parent().get_parent().get_node("Hud/LibroSuministros/ContainerPan/StockPan").set_text(text)
	elif comida == global.queso or comida == global.queso2:
		get_parent().get_parent().get_node("Sonidos/SamplePlayer2D").play("Crujir", 1)
		get_parent().get_parent().get_node("Hud/Container").stock_queso -= 1
		var text = str(get_parent().get_parent().get_node("Hud/Container").stock_queso) + "/20"
		get_parent().get_parent().get_node("Hud/LibroSuministros/ContainerQueso/StockQueso").set_text(text)
	elif comida == global.huevo or comida == global.huevo2:
		get_parent().get_parent().get_node("Sonidos/SamplePlayer2D").play("Coger", 1)
		get_parent().get_parent().get_node("Hud/Container").stock_huevos -= 1
		var text = str(get_parent().get_parent().get_node("Hud/Container").stock_huevos) + "/24"
		get_parent().get_parent().get_node("Hud/LibroSuministros/ContainerHuevos/StockHuevos").set_text(text)

func eliminar_sprites(ruta):
	for i in range(0, ruta.get_child_count()):
		ruta.get_child(i).queue_free()
#Esta función sirve para volver a dejar un alimento en una caja o para
#dejar un plato de comida en el caldero
func dejarComida(comida, hijo):
	if hijo == "0":
		personaje.get_child(0).free()
	elif hijo == "1":
		personaje.get_child(1).free()
	
	if comida == "Carne":
		get_parent().get_parent().get_node("Sonidos/SamplePlayer2D").play("Coger_2", 1)
		get_parent().get_parent().get_node("Hud/Container").stock_carne += 1
		var text = str(get_parent().get_parent().get_node("Hud/Container").stock_carne) + "/10"
		get_parent().get_parent().get_node("Hud/LibroSuministros/ContainerCarne/StockCarne").set_text(text)
	elif comida == "Pescado":
		get_parent().get_parent().get_node("Sonidos/SamplePlayer2D").play("Coger_2", 1)
		get_parent().get_parent().get_node("Hud/Container").stock_pescado += 1
		var text = str(get_parent().get_parent().get_node("Hud/Container").stock_pescado) + "/10"
		get_parent().get_parent().get_node("Hud/LibroSuministros/ContainerPescado/StockPescado").set_text(text)
	elif comida == "Verdura":
		get_parent().get_parent().get_node("Sonidos/SamplePlayer2D").play("Coger", 1)
		get_parent().get_parent().get_node("Hud/Container").stock_verduras += 1
		var text = str(get_parent().get_parent().get_node("Hud/Container").stock_verduras) + "/60"
		get_parent().get_parent().get_node("Hud/LibroSuministros/ContainerVerduras/StockVerduras").set_text(text)
	elif comida == "Patata":
		get_parent().get_parent().get_node("Sonidos/SamplePlayer2D").play("Coger", 1)
		get_parent().get_parent().get_node("Hud/Container").stock_patatas += 1
		var text = str(get_parent().get_parent().get_node("Hud/Container").stock_patatas) + "/80"
		get_parent().get_parent().get_node("Hud/LibroSuministros/ContainerPatatas/StockPatatas").set_text(text)
	elif comida == "Pan":
		get_parent().get_parent().get_node("Sonidos/SamplePlayer2D").play("Crujir", 1)
		get_parent().get_parent().get_node("Hud/Container").stock_pan += 1
		var text = str(get_parent().get_parent().get_node("Hud/Container").stock_pan) + "/20"
		get_parent().get_parent().get_node("Hud/LibroSuministros/ContainerPan/StockPan").set_text(text)
	elif comida == "Queso":
		get_parent().get_parent().get_node("Sonidos/SamplePlayer2D").play("Crujir", 1)
		get_parent().get_parent().get_node("Hud/Container").stock_queso += 1
		var text = str(get_parent().get_parent().get_node("Hud/Container").stock_queso) + "/20"
		get_parent().get_parent().get_node("Hud/LibroSuministros/ContainerQueso/StockQueso").set_text(text)
	elif comida == "Huevo":
		get_parent().get_parent().get_node("Sonidos/SamplePlayer2D").play("Coger", 1)
		get_parent().get_parent().get_node("Hud/Container").stock_huevos += 1
		var text = str(get_parent().get_parent().get_node("Hud/Container").stock_huevos) + "/24"
		get_parent().get_parent().get_node("Hud/LibroSuministros/ContainerHuevos/StockHuevos").set_text(text)