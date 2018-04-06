extends Sprite
#Este script se utiliza para gestionar la inteligencia artificial de los NPCs
var speed = 100
const eps = 1.5
var points = [] 
var panel = Vector2(-10, -41)
var navegacion = null setget set_navegacion
var destinos = null setget set_destinos
var precios = null setget set_precios
var menu = null setget set_menu
var objeto = null setget set_objeto
var reputacion = null setget set_reputacion
var dinero = null setget set_dinero
var destino = null
var destinoRuta = ""
var andar = false
var volver = false
var animationPlayer
var rigidBody
var tiempoEspera = Timer.new()
var tiempoEspera2 = Timer.new()
var tiempoBeberComer = Timer.new()
var contador_barra = 0
var contador_barriles = 0
var contador_sillas = 0
var barra 
var barril 
var silla 
var pedido
var pedidoRuta = ""
var barras = []
var barriles = []
var sillas = []
var sprite
var he_pedido = false

func _ready():
	set_fixed_process(true)
	set_frame(12)
	rigidBody = get_parent()
	animationPlayer = get_parent().get_node("AnimationPlayer")
	tiempoEspera.set_one_shot(true)
	self.add_child(tiempoEspera)
	tiempoEspera2.set_one_shot(true)
	self.add_child(tiempoEspera2)
	tiempoBeberComer.set_one_shot(true)
	self.add_child(tiempoBeberComer)
	get_parent().get_node("Label").hide()
	get_parent().get_node("Pedido").hide()
	
	barras = ["Barra1", "Barra2", "Barra3", "Barra4", "Barra5", "Barra6", "Barra7", "Barra8", "Barra9", "Barra10", "Barra11", "Barra12", "Barra13", "Barra14", "Barra15", "Barra16", "Barra17", "Barra18", "Barra19"]
	barriles = ["Barril1", "Barril2", "Barril3", "Barril4", "Barril5", "Barril6", "Barril7"]
	sillas = ["Silla", "Silla1", "Silla2", "Silla3", "Silla4", "Silla5", "Silla6", "Silla7", "Silla8", "Silla9", "Silla10", "Silla11", "Silla12", "Silla13", "Silla14", "Silla15", "Silla16", "Silla17", "Silla18", "Silla19", "Silla20", "Silla21", "Silla22", "Silla23", "Silla24", "Silla25", "Silla26", "Silla27", "Silla28", "Silla29", "Silla30", "Silla31", "Silla32", "Silla33", "Silla34", "Silla35", "Silla36", "Silla37", "Silla38", "Silla39", "Silla40", "Silla41", "Silla42", "Silla43"]
	
	barra_aleatoria()
	barril_aleatorio()
	silla_aleatoria()
	pass

func _fixed_process(delta):
	get_parent().get_node("Label").set_text(str(int(tiempoEspera2.get_time_left())))
	if andar == true and volver == false:
		moverNpc()
	elif andar == false and volver == true:
		destino = Vector2(511.213989, 652.04303)
		moverNpc()
	elif andar == true and volver == true:
		get_parent().queue_free()
	if animationPlayer.get_current_animation() != "Andar arriba" and rigidBody.get_linear_velocity().y < 0 and abs(rigidBody.get_linear_velocity().y) > abs(rigidBody.get_linear_velocity().x):
		set_frame(12)
		get_parent().get_node("AnimationPlayer").play("Andar arriba")
	elif animationPlayer.get_current_animation() != "Andar abajo" and rigidBody.get_linear_velocity().y > 0 and abs(rigidBody.get_linear_velocity().y) > abs(rigidBody.get_linear_velocity().x):
		set_frame(0)
		get_parent().get_node("AnimationPlayer").play("Andar abajo")
	elif animationPlayer.get_current_animation() != "Andar izquierda" and rigidBody.get_linear_velocity().x < 0 and abs(rigidBody.get_linear_velocity().x) > abs(rigidBody.get_linear_velocity().y):
		set_frame(4)
		get_parent().get_node("AnimationPlayer").play("Andar izquierda")
	elif animationPlayer.get_current_animation() != "Andar derecha" and rigidBody.get_linear_velocity().x > 0 and abs(rigidBody.get_linear_velocity().x) > abs(rigidBody.get_linear_velocity().y):
		set_frame(8)
		get_parent().get_node("AnimationPlayer").play("Andar derecha")

func set_navegacion(navegacion_nueva):
	navegacion = navegacion_nueva

func set_destinos(destinos_nuevos):
	destinos = destinos_nuevos

func set_menu(menu_nuevo):
	menu = menu_nuevo
	obtener_destino()

func set_precios(precios_nuevo):
	precios = precios_nuevo

func set_objeto(objeto_nuevo):
	objeto = objeto_nuevo

func set_reputacion(reputacion_nueva):
	reputacion = reputacion_nueva

func set_dinero(dinero_nuevo):
	dinero = dinero_nuevo
#Esta función sirve para mover al NPC hasta un determinado lugar
func moverNpc():
	points = navegacion.get_simple_path(rigidBody.get_global_pos(), destino, true)
	if points.size() > 1:
		var distance = points[1] -  rigidBody.get_global_pos() 
		var direction = distance.normalized()
		if distance.length() > eps or points.size() > 2:
			rigidBody.set_linear_velocity(direction*speed)
		elif distance.length() <= eps and volver == true and andar == false:
			andar = true
		else:
			rigidBody.set_linear_velocity(Vector2(0, 0))
			andar = false
			animationPlayer.stop()
			obtener_orientacion()
			destinos[destinoRuta].set_npc(get_parent())
			esperar()
		rigidBody.update()

func barra_aleatoria():
	randomize()
	barra = randi()%19+0

func barril_aleatorio():
	randomize()
	barril = randi()%7+0

func silla_aleatoria():
	randomize()
	silla = randi()%44+0

func pedido_aleatorio():
	randomize()
	pedido = randi()%menu.keys().size()+0
#Esta función sirve para obtener un destino aleatorio en función de lo que
#el cliente ha pedido. Si pide algo de beber puede ir a cualquier sitio
#de la taberna, pero si piden cualquier cosa de comer, van directamente a 
#las mesas. Comprobando previamente que hay sitio libre en la barra, en los
#barriles o en las sillas
func obtener_destino():
	if pedidoRuta ==  "":
		obtener_pedido()
	for i in range(barras.size()):
		if  destinos[barras[i]].get_ocupado() == true:
			contador_barra += 1
	for i in range(barriles.size()):
		if  destinos[barriles[i]].get_ocupado() == true:
			contador_barriles += 1
	for i in range(sillas.size()):
		if  destinos[sillas[i]].get_ocupado() == true:
			contador_sillas += 1
	if pedidoRuta == "res://Scenes/JarraVino.tscn" or pedidoRuta == "res://Scenes/JarraCerveza.tscn":
		if contador_barra < 19 and destino == null:
			if destinos[barras[barra]].get_ocupado() == false:
				destino = destinos[barras[barra]].get_posicion()
				destinoRuta = barras[barra]
				destinos[barras[barra]].set_ocupado(true)
			else:
				contador_barra = 0
				contador_barriles = 0
				contador_sillas = 0
				barra_aleatoria()
				obtener_destino()
		elif contador_barriles < 7 and contador_barra == 19 and destino == null:
			if destinos[barriles[barril]].get_ocupado() == false:
				destino = destinos[barriles[barril]].get_posicion()
				destinoRuta = barriles[barril]
				destinos[barriles[barril]].set_ocupado(true)
			else:
				contador_barra = 0
				contador_barriles = 0
				contador_sillas = 0
				barril_aleatorio()
				obtener_destino()
	if ((contador_sillas < 44 and contador_barra == 19 and contador_barriles == 7) or (contador_sillas < 44 and pedidoRuta !="res://Scenes/JarraVino.tscn" and pedidoRuta != "res://Scenes/JarraCerveza.tscn")) and destino == null:
		if destinos[sillas[silla]].get_ocupado() == false:
			destino = destinos[sillas[silla]].get_posicion()
			destinoRuta = sillas[silla]
			destinos[sillas[silla]].set_ocupado(true)
		else:
			contador_barra = 0
			contador_barriles = 0
			contador_sillas = 0
			silla_aleatoria()
			obtener_destino()
#Esta función sirve para poner al NPC a esperar a ser servido. Consta de dos
#temporizadores. El primero no aparece en pantalla, y en cuanto éste se acaba
#y aun no ha sido servido, comienza el segundo, el cual si aparece en pantalla
#(para infundir un poco de presión al jugador). En cuanto el NPC es atendido,
#se paran ambos temporizadores. Si se acaba el segundo temporizador, el NPC 
#se marcha de la taberna y se resta reputación
func esperar():
	get_parent().get_node("Pedido").show()
	tiempoEspera.set_wait_time(30)
	tiempoEspera.start()
	yield(tiempoEspera, "timeout")
	if he_pedido == false:
		get_parent().get_node("Label").show()
		tiempoEspera2.set_wait_time(30)
		tiempoEspera2.start()
		yield(tiempoEspera2, "timeout")
		get_parent().get_node("Pedido").hide()
		get_parent().get_node("Label").hide()
		reputacion.menosExperiencia()
		destinos[destinoRuta].set_ocupado(false)
		destinos[destinoRuta].set_npc(null)
		volver = true
#Esta función sirve para establecer la orientación del NPC en función
#del lugar donde vaya
func obtener_orientacion():
	set_frame(destinos[destinoRuta].get_orientacion())
#Esta función sirve para obtener un pedido aleatorio para el NPC. En cuanto 
#vayan estando disponibles los distintos productos, podrán ser solicitados
#(aleatoriamente) por los NPCs, puntualizando una cosa. Si piden algo de comer
#(a excepción de pan o queso) automáticamente se cambiará por el plato del día
#establecido como variable global.
func obtener_pedido():
	pedido_aleatorio()
	var claves = menu.keys()
	if claves[pedido] == "res://Scenes/JarraVino.tscn":
		sprite = preload("res://Scenes/JarraVino.tscn")
		get_parent().get_node("Pedido/Sprite")
		get_parent().get_node("Pedido/Sprite").set_pos(Vector2(10.84644, 13.2329))
		pedidoRuta = claves[pedido]
		get_parent().get_node("Pedido/Sprite").set_region_rect(menu[claves[pedido]])
	elif claves[pedido] == "res://Scenes/JarraCerveza.tscn":
		sprite = preload("res://Scenes/JarraCerveza.tscn")
		get_parent().get_node("Pedido/Sprite").set_pos(Vector2(9.84644, 10.2329))
		pedidoRuta = claves[pedido]
		get_parent().get_node("Pedido/Sprite").set_region_rect(menu[claves[pedido]])
	elif claves[pedido] == "res://Scenes/pan.tscn":
		sprite = preload("res://Scenes/pan.tscn")
		get_parent().get_node("Pedido/Sprite").set_pos(Vector2(9.84644, 10.2329))
		get_parent().get_node("Pedido/Sprite").set_scale(Vector2(0.4, 0.4))
		pedidoRuta = claves[pedido]
		get_parent().get_node("Pedido/Sprite").set_region_rect(menu[claves[pedido]])
	elif claves[pedido] == "res://Scenes/queso.tscn":
		sprite = preload("res://Scenes/queso.tscn")
		get_parent().get_node("Pedido/Sprite").set_pos(Vector2(9.84644, 10.2329))
		get_parent().get_node("Pedido/Sprite").set_scale(Vector2(0.5, 0.5))
		pedidoRuta = claves[pedido]
		get_parent().get_node("Pedido/Sprite").set_region_rect(menu[claves[pedido]])
	elif global.plato_hoy != "":
		if global.plato_hoy == "res://Scenes/carneCocinada.tscn":
			sprite = preload("res://Scenes/carneCocinada.tscn")
			get_parent().get_node("Pedido/Sprite").set_pos(Vector2(11.54644, 10.2329))
			get_parent().get_node("Pedido/Sprite").set_scale(Vector2(0.7, 0.7))
		elif global.plato_hoy == "res://Scenes/pescadoCocinado.tscn":
			sprite = preload("res://Scenes/pescadoCocinado.tscn")
			get_parent().get_node("Pedido/Sprite").set_pos(Vector2(9.54644, 10.2329))
			get_parent().get_node("Pedido/Sprite").set_scale(Vector2(0.45, 0.45))
		elif global.plato_hoy == "res://Scenes/sopa.tscn":
			sprite = preload("res://Scenes/sopa.tscn")
			get_parent().get_node("Pedido/Sprite").set_pos(Vector2(11.84644, 10.2329))
			get_parent().get_node("Pedido/Sprite").set_scale(Vector2(1, 1))
		elif global.plato_hoy == "res://Scenes/quebrantos.tscn":
			sprite = preload("res://Scenes/quebrantos.tscn")
			get_parent().get_node("Pedido/Sprite").set_pos(Vector2(9.84644, 10.2329))
			get_parent().get_node("Pedido/Sprite").set_scale(Vector2(1, 1))
		elif global.plato_hoy == "res://Scenes/olla.tscn":
			sprite = preload("res://Scenes/olla.tscn")
			get_parent().get_node("Pedido/Sprite").set_pos(Vector2(10.84644, 10.2329))
			get_parent().get_node("Pedido/Sprite").set_scale(Vector2(1, 1))
		elif global.plato_hoy == "res://Scenes/estofado.tscn":
			sprite = preload("res://Scenes/estofado.tscn")
			get_parent().get_node("Pedido/Sprite").set_pos(Vector2(9.84644, 10.2329))
			get_parent().get_node("Pedido/Sprite").set_scale(Vector2(1, 1))
		pedidoRuta = global.plato_hoy
		get_parent().get_node("Pedido/Sprite").set_region_rect(menu[global.plato_hoy])
	if sprite == null:
		obtener_pedido()
	else:
		var instancia = sprite.instance()
		get_parent().get_node("Pedido/Sprite").set_texture(instancia.get_texture())
		get_parent().get_node("Pedido/Sprite").set_region(true)
#Esta función simplemente consta de un temporizador, que se utiliza como
#el tiempo que tarda el NPC en comer o beber, y en cuanto termina, se elimina
#el objeto que tenía en la mano y se añade la reputación correspondiente
func beber_comer():
	tiempoEspera.stop()
	tiempoEspera2.stop()
	he_pedido = true
	get_parent().get_node("Label").hide()
	tiempoBeberComer.set_wait_time(10)
	tiempoBeberComer.start()
	yield(tiempoBeberComer, "timeout")
	volver = true
	remove_child(objeto)
	objeto.free()
	reputacion.masExperiencia()
	pagar()
#Esta función sirve para añadir el dinero que cuesta el producto
#que ha consumido al dinero total
func pagar():
	var precio = precios[pedidoRuta]
	var dinero_actual = int(dinero.get_text())
	dinero_actual += precio
	dinero.set_text(str(dinero_actual))
	destinos[destinoRuta].set_ocupado(false)
	destinos[destinoRuta].set_npc(null)
	
	