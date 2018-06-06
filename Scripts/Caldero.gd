extends Node

var personaje
var notificaciones
var caldero
var spriteCaldero = preload("res://Scenes/Caldero.tscn")
var calderoAnimado = spriteCaldero.instance()
var tiempo = Timer.new()
var comidaCocinada = false
var cocina = false
var pos_caldero = Vector2(592, 48)
var contadorCarne = 0
var contadorPescado = 0
var contadorVerduras = 0
var contadorPatatas = 0
var contadorHuevos = 0

func _ready():
	set_fixed_process(true)
	caldero = get_node("Caldero")
	notificaciones = get_parent().get_parent().get_node("Hud/Notificaciones")
	personaje = get_parent().get_parent().get_node("KinematicBody2D/Personaje")
	calderoAnimado.set_pos(pos_caldero)
	get_parent().get_parent().get_node("Hud/Cocina").hide()
	get_parent().get_parent().get_node("Hud/Raciones").hide()
	tiempo.set_one_shot(true)
	self.add_child(tiempo)
	caldero.hide()
	pass
#Esta función, que es propia de godot y comprueba varias cosas en cada frame
#del juego, se utiliza para dos cosas. Sirve para mostrar el tiempo que queda
#para que una determinada comida se termine de cocinar en el caldero, y una
#vez que haya terminado, para mostrar el número de raciones que hay en dicho 
#caldero.
func _fixed_process(delta):
	get_parent().get_parent().get_node("Hud/Cocina").set_text(str(int(tiempo.get_time_left())))
	get_parent().get_parent().get_node("Hud/Raciones").set_text(str(caldero.get_child_count()) + " raciones")
	if caldero.get_child_count() == 0:
		get_parent().get_parent().get_node("Hud/Raciones").hide()
		comidaCocinada = false
	for i in range(0, caldero.get_child_count()):
		if caldero.get_child(i).get_filename() == global.spriteCarneCocinada.get_path() or caldero.get_child(i).get_filename() == global.spritePescadoCocinado.get_path() or caldero.get_child(i).get_filename() == global.spriteQuebrantos.get_path() or caldero.get_child(i).get_filename() == global.spriteSopa.get_path() or caldero.get_child(i).get_filename() == global.spriteOlla.get_path() or caldero.get_child(i).get_filename() == global.spriteEstofado.get_path():
			get_parent().get_parent().get_node("Hud/Raciones").show()
			comidaCocinada = true
#Esta parte gestiona la interracción con el caldero, y lo que
#hace es que el personaje suelte los alimentos y los eche en el caldero, 
#teniendo en cuenta si lo que tiene en las manos se puede echar en el caldero
#o no. Si tiene las manos vacías, hay alimentos en el caldero, y si lo
#que hay dentro se corresponde al patrón de una receta determinada, al
#hacer la interacción provoca que se empiece a cocinar todo. Si lo
#que hay dentro no corresponde a una receta, el juego te informará a
#través de una notificación de que la comida se desperdició
func interaccion_caldero():
	if personaje.get_child_count() == 0:
		if caldero.get_child_count() == 0 and cocina == false:
			notificaciones.notificaciones("Necesitas ingredientes")
		elif caldero.get_child_count() > 0:
			if contadorCarne == 1 and caldero.get_child_count() == 1:
				tiempo.set_wait_time(20)
				cocina("Carne cocinada")
			elif caldero.get_child(0).get_filename() == global.spriteCarneCocinada.get_path():
				cogerComidaCocinada("Carne", "Derecha")
			elif contadorPescado == 1 and caldero.get_child_count() == 1:
				tiempo.set_wait_time(20)
				cocina("Pescado cocinado")
			elif caldero.get_child(0).get_filename() == global.spritePescadoCocinado.get_path():
				cogerComidaCocinada("Pescado", "Derecha")
			elif contadorCarne == 1 and contadorHuevos == 2:
				tiempo.set_wait_time(30)
				cocina("Quebrantos")
			elif caldero.get_child(0).get_filename() == global.spriteQuebrantos.get_path():
				cogerComidaCocinada("Quebrantos", "Derecha")
			elif contadorPatatas == 5 and contadorVerduras == 5:
				tiempo.set_wait_time(45)
				cocina("Sopa")
			elif caldero.get_child(0).get_filename() == global.spriteSopa.get_path():
				cogerComidaCocinada("Sopa", "Derecha")
			elif contadorVerduras == 5 and contadorCarne == 5:
				tiempo.set_wait_time(60)
				cocina("Olla")
			elif caldero.get_child(0).get_filename() == global.spriteOlla.get_path():
				cogerComidaCocinada("Olla", "Derecha")
			elif contadorPatatas == 5 and contadorCarne == 5:
				tiempo.set_wait_time(60)
				cocina("Estofado")
			elif caldero.get_child(0).get_filename() == global.spriteEstofado.get_path():
				cogerComidaCocinada("Estofado", "Derecha")
			else:
				notificaciones.notificaciones("La comida se desperdició")
				for i in range(0, caldero.get_child_count()):
					caldero.get_child(i).queue_free()
		else:
			notificaciones.notificaciones("Aún no ha terminado")
	elif personaje.get_child_count() == 1:
		if cocina == false:
			if comidaCocinada == false:
				if personaje.get_child(0).get_filename() == global.spriteCarne.get_path():
					if personaje.get_child(0).get_pos() == global.mano_derecha:
						echarIngrediente(global.carne)
						global.instanciar_ingredientes(global.carne)
					else:
						echarIngrediente(global.carne2)
						global.instanciar_ingredientes(global.carne2)
					notificaciones.notificaciones("Has añadido carne")
					contadorCarne += 1
				elif personaje.get_child(0).get_filename() == global.spritePescado.get_path():
					if personaje.get_child(0).get_pos() == global.mano_derecha:
						echarIngrediente(global.pescado)
						global.instanciar_ingredientes(global.pescado)
					else:
						echarIngrediente(global.pescado2)
						global.instanciar_ingredientes(global.pescado2)
					notificaciones.notificaciones("Has añadido pescado")
					contadorPescado += 1
				elif personaje.get_child(0).get_filename() == global.spriteVerduras.get_path():
					if personaje.get_child(0).get_pos() == global.mano_derecha:
						echarIngrediente(global.verdura)
						global.instanciar_ingredientes(global.verdura)
					else:
						echarIngrediente(global.verdura2)
						global.instanciar_ingredientes(global.verdura2)
					notificaciones.notificaciones("Has añadido verdura")
					contadorVerduras += 1
				elif personaje.get_child(0).get_filename() == global.spritePatatas.get_path():
					if personaje.get_child(0).get_pos() == global.mano_derecha:
						echarIngrediente(global.patata)
						global.instanciar_ingredientes(global.patata)
					else:
						echarIngrediente(global.patata2)
						global.instanciar_ingredientes(global.patata2)
					notificaciones.notificaciones("Has añadido una patata")
					contadorPatatas += 1
				elif personaje.get_child(0).get_filename() == global.spriteHuevos.get_path():
					if personaje.get_child(0).get_pos() == global.mano_derecha:
						echarIngrediente(global.huevo)
						global.instanciar_ingredientes(global.huevo)
					else:
						echarIngrediente(global.huevo2)
						global.instanciar_ingredientes(global.huevo2)
					notificaciones.notificaciones("Has añadido un huevo")
					contadorHuevos += 1
				else:
					notificaciones.notificaciones("No puedes añadir esto")
			else:
				if caldero.get_child_count() > 0 and contadorCarne == 0 and contadorPescado == 0 and contadorVerduras == 0 and contadorPatatas == 0 and contadorHuevos == 0:
					if caldero.get_child(0).get_filename() == global.spriteCarneCocinada.get_path() and personaje.get_child(0).get_pos() == global.mano_derecha:
						cogerComidaCocinada("Carne", "Izquierda")
					elif caldero.get_child(0).get_filename() == global.spriteCarneCocinada.get_path() and personaje.get_child(0).get_pos() == global.mano_izquierda:
						cogerComidaCocinada("Carne", "Derecha")
					elif caldero.get_child(0).get_filename() == global.spritePescadoCocinado.get_path() and personaje.get_child(0).get_pos() == global.mano_derecha:
						cogerComidaCocinada("Pescado", "Izquierda")
					elif caldero.get_child(0).get_filename() == global.spritePescadoCocinado.get_path() and personaje.get_child(0).get_pos() == global.mano_izquierda:
						cogerComidaCocinada("Pescado", "Derecha")
					elif caldero.get_child(0).get_filename() == global.spriteQuebrantos.get_path() and personaje.get_child(0).get_pos() == global.mano_derecha:
						cogerComidaCocinada("Quebrantos", "Izquierda")
					elif caldero.get_child(0).get_filename() == global.spriteQuebrantos.get_path() and personaje.get_child(0).get_pos() == global.mano_izquierda:
						cogerComidaCocinada("Quebrantos", "Derecha")
					elif caldero.get_child(0).get_filename() == global.spriteSopa.get_path() and personaje.get_child(0).get_pos() == global.mano_derecha:
						cogerComidaCocinada("Sopa", "Izquierda")
					elif caldero.get_child(0).get_filename() == global.spriteSopa.get_path() and personaje.get_child(0).get_pos() == global.mano_izquierda:
						cogerComidaCocinada("Sopa", "Derecha")
					elif caldero.get_child(0).get_filename() == global.spriteOlla.get_path() and personaje.get_child(0).get_pos() == global.mano_derecha:
						cogerComidaCocinada("Olla", "Izquierda")
					elif caldero.get_child(0).get_filename() == global.spriteOlla.get_path() and personaje.get_child(0).get_pos() == global.mano_izquierda:
						cogerComidaCocinada("Olla", "Derecha")
					elif caldero.get_child(0).get_filename() == global.spriteEstofado.get_path() and personaje.get_child(0).get_pos() == global.mano_derecha:
						cogerComidaCocinada("Estofado", "Izquierda")
					elif caldero.get_child(0).get_filename() == global.spriteEstofado.get_path() and personaje.get_child(0).get_pos() == global.mano_izquierda:
						cogerComidaCocinada("Estofado", "Derecha")
		else:
			notificaciones.notificaciones("Aun no ha terminado")
	elif personaje.get_child_count() == 2:
		if cocina == false:
			if comidaCocinada == false:
				if personaje.get_child(0).get_filename() == global.spriteCarne.get_path() or personaje.get_child(1).get_filename() == global.spriteCarne.get_path():
					if (personaje.get_child(0).get_filename() == global.spriteCarne.get_path() and personaje.get_child(0).get_pos() == global.mano_derecha) or (personaje.get_child(1).get_filename() == global.spriteCarne.get_path() and personaje.get_child(1).get_pos() == global.mano_derecha):
						echarIngrediente(global.carne)
						global.instanciar_ingredientes(global.carne)
					else:
						echarIngrediente(global.carne2)
						global.instanciar_ingredientes(global.carne2)
					notificaciones.notificaciones("Has añadido carne")
					contadorCarne += 1
				elif personaje.get_child(0).get_filename() == global.spriteVerduras.get_path() or personaje.get_child(1).get_filename() == global.spriteVerduras.get_path():
					if (personaje.get_child(0).get_filename() == global.spriteVerduras.get_path() and personaje.get_child(0).get_pos() == global.mano_derecha) or (personaje.get_child(1).get_filename() == global.spriteVerduras.get_path() and personaje.get_child(1).get_pos() == global.mano_derecha):
						echarIngrediente(global.verdura)
						global.instanciar_ingredientes(global.verdura)
					else:
						echarIngrediente(global.verdura2)
						global.instanciar_ingredientes(global.verdura2)
					notificaciones.notificaciones("Has añadido verdura")
					contadorVerduras += 1
				elif personaje.get_child(0).get_filename() == global.spritePatatas.get_path() or personaje.get_child(1).get_filename() == global.spritePatatas.get_path():
					if (personaje.get_child(0).get_filename() == global.spritePatatas.get_path() and personaje.get_child(0).get_pos() == global.mano_derecha) or (personaje.get_child(1).get_filename() == global.spritePatatas.get_path() and personaje.get_child(1).get_pos() == global.mano_derecha):
						echarIngrediente(global.patata)
						global.instanciar_ingredientes(global.patata)
					else:
						echarIngrediente(global.patata2)
						global.instanciar_ingredientes(global.patata2)
					notificaciones.notificaciones("Has añadido una patata")
					contadorPatatas += 1
				elif personaje.get_child(0).get_filename() == global.spriteHuevos.get_path() or personaje.get_child(1).get_filename() == global.spriteHuevos.get_path():
					if (personaje.get_child(0).get_filename() == global.spriteHuevos.get_path() and personaje.get_child(0).get_pos() == global.mano_derecha) or (personaje.get_child(1).get_filename() == global.spriteHuevos.get_path() and personaje.get_child(1).get_pos() == global.mano_derecha):
						echarIngrediente(global.huevo)
						global.instanciar_ingredientes(global.huevo)
					else:
						echarIngrediente(global.huevo2)
						global.instanciar_ingredientes(global.huevo2)
					notificaciones.notificaciones("Has añadido un huevo")
					contadorHuevos += 1
				elif personaje.get_child(0).get_filename() == global.spritePescado.get_path() or personaje.get_child(1).get_filename() == global.spritePescado.get_path():
					if (personaje.get_child(0).get_filename() == global.spritePescado.get_path() and personaje.get_child(0).get_pos() == global.mano_derecha) or (personaje.get_child(1).get_filename() == global.spritePescado.get_path() and personaje.get_child(1).get_pos() == global.mano_derecha):
						echarIngrediente(global.pescado)
						global.instanciar_ingredientes(global.pescado)
					else:
						echarIngrediente(global.pescado2)
						global.instanciar_ingredientes(global.pescado2)
					notificaciones.notificaciones("Has añadido un pescado")
					contadorPescado += 1
				else:
					notificaciones.notificaciones("No puedes añadir esto")
			else:
				notificaciones.notificaciones("Tienes las manos ocupadas")
		else:
			notificaciones.notificaciones("Aun no ha terminado")

func dejar_comida_cocinada(comida, hijo):
	if hijo == "0":
		personaje.get_child(0).free()
	elif hijo == "1":
		personaje.get_child(1).free()
	
	get_parent().get_parent().get_node("Sonidos/SamplePlayer2D").play("Dejar_objeto", 1)
		
	var comidaCocinada
	if comida == "Carne cocinada":
		comidaCocinada = global.spriteCarneCocinada.instance()
		caldero.add_child(comidaCocinada)
		comidaCocinada.hide()
	elif comida == "Pescado cocinado":
		comidaCocinada = global.spritePescadoCocinado.instance()
		caldero.add_child(comidaCocinada)
		comidaCocinada.hide()
	elif comida == "Quebrantos":
		comidaCocinada = global.spriteQuebrantos.instance()
		caldero.add_child(comidaCocinada)
		comidaCocinada.hide()
	elif comida == "Sopa":
		comidaCocinada = global.spriteSopa.instance()
		caldero.add_child(comidaCocinada)
		comidaCocinada.hide()
	elif comida == "Olla":
		comidaCocinada = global.spriteOlla.instance()
		caldero.add_child(comidaCocinada)
		comidaCocinada.hide()
	elif comida == "Estofado":
		comidaCocinada = global.spriteEstofado.instance()
		caldero.add_child(comidaCocinada)
		comidaCocinada.hide()

#Esta función sirve para echar un alimento al caldero
func echarIngrediente(ingrediente):
	get_parent().get_parent().get_node("Sonidos/SamplePlayer2D").play("Echar_comida", 1)
	personaje.remove_child(ingrediente)
	caldero.add_child(ingrediente)
	ingrediente.hide()
#Esta función sirve para cocinar los alimentos que hay en el caldero, 
#eliminando primero todo lo que haya dentro del mismo. Después se establece
#un temporizador(que se visualiza en pantalla) que simula lo que le falta a
#la comida para que esté lista, y una vez este acabe, se generan las 
#correspondientes raciones dependiendo de la receta que se haya seguido
func cocina(receta):
	for i in range(0, caldero.get_child_count()):
		caldero.get_child(i).queue_free()

	global.instanciar_ingredientes(global.carne)
	global.instanciar_ingredientes(global.carne2)
	global.instanciar_ingredientes(global.pescado)
	global.instanciar_ingredientes(global.pescado2)
	global.instanciar_ingredientes(global.verdura)
	global.instanciar_ingredientes(global.verdura2)
	global.instanciar_ingredientes(global.patata)
	global.instanciar_ingredientes(global.patata2)
	global.instanciar_ingredientes(global.huevo)
	global.instanciar_ingredientes(global.huevo2)
	
	cocina = true
	notificaciones.notificaciones("La comida se está cocinando")
	get_parent().get_parent().get_node("Hud/Cocina").show()
	remove_child(caldero)
	add_child(calderoAnimado)
	calderoAnimado.get_node("AnimationPlayer").play("Hervir")
	get_parent().get_parent().get_node("Sonidos/SamplePlayer2D").play("Cocina", 2)
	tiempo.start()
	yield(tiempo, "timeout")
	if receta == "Carne cocinada":
		for i in range(0,4):
			var carneCocinada = global.spriteCarneCocinada.instance()
			caldero.add_child(carneCocinada)
			carneCocinada.hide()
	elif receta == "Pescado cocinado":
		for i in range(0,4):
			var pescadoCocinado = global.spritePescadoCocinado.instance()
			caldero.add_child(pescadoCocinado)
			pescadoCocinado.hide()
	elif receta == "Quebrantos":
		for i in range(2):
			var quebrantos = global.spriteQuebrantos.instance()
			caldero.add_child(quebrantos)
			quebrantos.hide()
	elif receta == "Sopa":
		for i in range(0,10):
			var sopa = global.spriteSopa.instance()
			caldero.add_child(sopa)
			sopa.hide()
	elif receta == "Olla":
		for i in range(0,10):
			var olla = global.spriteOlla.instance()
			caldero.add_child(olla)
			olla.hide()
	elif receta == "Estofado":
		for i in range(0,10):
			var estofado = global.spriteEstofado.instance()
			caldero.add_child(estofado)
			estofado.hide()
	notificaciones.notificaciones("La comida está lista")
	cocina = false
	get_parent().get_parent().get_node("Sonidos/SamplePlayer2D").stop_voice(2)
	contadorCarne = 0
	contadorPescado = 0
	contadorVerduras = 0
	contadorPatatas = 0
	contadorHuevos = 0
	get_parent().get_parent().get_node("Hud/Cocina").hide()
	get_parent().get_parent().get_node("Hud/Raciones").show()
	comidaCocinada = true
	calderoAnimado.get_node("AnimationPlayer").stop()
	remove_child(calderoAnimado)
	instanciar_caldero()
	add_child(caldero)
#Esta función sirve para coger la comida, una vez cocinada, del caldero
func cogerComidaCocinada(comida, mano):
	get_parent().get_parent().get_node("Sonidos/SamplePlayer2D").play("Dejar_objeto", 1)
	caldero.get_child(0).free()
	var comidaCocinada
	if comida == "Carne":
		comidaCocinada = global.spriteCarneCocinada.instance()
	elif comida == "Pescado":
		comidaCocinada = global.spritePescadoCocinado.instance()
	elif comida == "Quebrantos":
		comidaCocinada = global.spriteQuebrantos.instance()
	elif comida == "Sopa":
		comidaCocinada = global.spriteSopa.instance()
	elif comida == "Olla":
		comidaCocinada = global.spriteOlla.instance()
	elif comida == "Estofado":
		comidaCocinada = global.spriteEstofado.instance()
	personaje.add_child(comidaCocinada)
	if mano == "Derecha":
		comidaCocinada.set_pos(global.mano_derecha)
	elif mano == "Izquierda":
		comidaCocinada.set_pos(global.mano_izquierda)

func instanciar_caldero():
	calderoAnimado = spriteCaldero.instance()
	calderoAnimado.set_pos(pos_caldero)

func dejar_comida():
	if personaje.get_child_count() == 0:
		notificaciones.notificaciones("No tienes nada que soltar")
	elif (personaje.get_child_count() == 1 or personaje.get_child_count() == 2) and personaje.get_child(0).get_filename() == global.spriteCarneCocinada.get_path():
		dejar_comida_cocinada("Carne cocinada", "0")
	elif (personaje.get_child_count() == 1 or personaje.get_child_count() == 2) and personaje.get_child(0).get_filename() == global.spritePescadoCocinado.get_path():
		dejar_comida_cocinada("Pescado cocinado", "0")
	elif (personaje.get_child_count() == 1 or personaje.get_child_count() == 2) and personaje.get_child(0).get_filename() == global.spriteQuebrantos.get_path():
		dejar_comida_cocinada("Quebrantos", "0")
	elif (personaje.get_child_count() == 1 or personaje.get_child_count() == 2) and personaje.get_child(0).get_filename() == global.spriteSopa.get_path():
		dejar_comida_cocinada("Sopa", "0")
	elif (personaje.get_child_count() == 1 or personaje.get_child_count() == 2) and personaje.get_child(0).get_filename() == global.spriteOlla.get_path():
		dejar_comida_cocinada("Olla", "0")
	elif (personaje.get_child_count() == 1 or personaje.get_child_count() == 2) and personaje.get_child(0).get_filename() == global.spriteEstofado.get_path():
		dejar_comida_cocinada("Estofado", "0")
	elif  personaje.get_child_count() == 2 and personaje.get_child(1).get_filename() == global.spriteCarneCocinada.get_path():
		dejar_comida_cocinada("Carne cocinada", "1")
	elif personaje.get_child_count() == 2 and personaje.get_child(1).get_filename() == global.spritePescadoCocinado.get_path():
		dejar_comida_cocinada("Pescado cocinado", "1")
	elif personaje.get_child_count() == 2 and personaje.get_child(1).get_filename() == global.spriteQuebrantos.get_path():
		dejar_comida_cocinada("Quebrantos", "1")
	elif personaje.get_child_count() == 2 and personaje.get_child(1).get_filename() == global.spriteSopa.get_path():
		dejar_comida_cocinada("Sopa", "1")
	elif personaje.get_child_count() == 2 and personaje.get_child(1).get_filename() == global.spriteOlla.get_path():
		dejar_comida_cocinada("Olla", "1")
	elif personaje.get_child_count() == 2 and personaje.get_child(1).get_filename() == global.spriteEstofado.get_path():
		dejar_comida_cocinada("Estofado", "1")
	else:
		notificaciones.notificaciones("Esto no va aquí")