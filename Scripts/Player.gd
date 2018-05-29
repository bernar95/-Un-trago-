extends KinematicBody2D
#Este script sirve para gestionar todo lo referente al personaje
#controlado por el jugador
var direction = Vector2(0,0)
var startPos = Vector2(0,0)
var moving = false

var personaje
var animationPlayer
var mapa

var arriba
var abajo
var izquierda
var derecha

var estanteJarras
var barriles
var papelera
var cajas
var caldero
var notificaciones

var speed = 1
const GRID = 16

func _ready():
	mapa = get_world_2d().get_direct_space_state()
	set_fixed_process(true)
	set_process_input(true)
	personaje = get_node("Personaje")
	animationPlayer = get_node("AnimationPlayer")
	estanteJarras = get_parent().get_node("BarraDetras/EstanteJarras")
	barriles = get_parent().get_node("BarraDetras/Barriles")
	papelera = get_parent().get_node("Papelera ")
	cajas = get_parent().get_node("BarraDetras/Cajas")
	caldero = get_parent().get_node("BarraDetras/CalderoNode")
	notificaciones = get_parent().get_node("Hud/Notificaciones")
#Esta función, que es propia de godot y comprueba varias cosas en cada frame
#del juego, se utiliza para mover al personaje. Para lo cual 
#va comprobando si se pulsan las teclas WASD y si además se está pulsando en 
#conjunto con alguna de dichas teclas, la tecla SHIFT, lo cual provoca que el
#personaje corra en la dirección correspondiente
func _fixed_process(delta):
	if get_parent().get_node("Hud/Container").mostrarPedidos == false and get_parent().get_node("Hud/LibroSuministros").mostrarSuministros == false and get_parent().get_node("Hud/LibroRecetas").mostrarRecetas == false and get_parent().get_node("Hud/LibroCompras").mostrarCompras == false and get_parent().get_node("Hud/LibroPrecios").mostrarPrecios == false:
		if !moving:
			arriba = mapa.intersect_point(get_pos() + Vector2(0, -GRID))
			abajo = mapa.intersect_point(get_pos() + Vector2(0, GRID))
			izquierda = mapa.intersect_point(get_pos() + Vector2(-GRID, 0))
			derecha = mapa.intersect_point(get_pos() + Vector2(GRID, 0))
		
			if Input.is_key_pressed(KEY_W):
				personaje.set_frame(12)
				if arriba.empty():
					moving = true
					direction = Vector2(0, -1)
					startPos = get_pos()
					animationPlayer.play("Andar arriba")
					if Input.is_key_pressed(KEY_SHIFT):
						speed = 4
						animationPlayer.play("Andar arriba rapido")
					elif Input.is_key_pressed(KEY_SHIFT) == false:
						speed = 1
			elif Input.is_key_pressed(KEY_S):
				personaje.set_frame(0)
				if abajo.empty():
					moving = true
					direction = Vector2(0, 1)
					startPos = get_pos()
					animationPlayer.play("Andar abajo")
					if Input.is_key_pressed(KEY_SHIFT):
						speed = 4
						animationPlayer.play("Andar abajo rapido")
					elif Input.is_key_pressed(KEY_SHIFT) == false:
						speed = 1
			elif Input.is_key_pressed(KEY_A):
				personaje.set_frame(4)
				if izquierda.empty():
					moving = true
					direction = Vector2(-1, 0)
					startPos = get_pos()
					animationPlayer.play("Andar izquierda")
					if Input.is_key_pressed(KEY_SHIFT):
						speed = 4
						animationPlayer.play("Andar izquierda rapido")
					elif Input.is_key_pressed(KEY_SHIFT) == false:
						speed = 1
			elif Input.is_key_pressed(KEY_D):
				personaje.set_frame(8)
				if derecha.empty():
					moving = true
					direction = Vector2(1, 0)
					startPos = get_pos()
					animationPlayer.play("Andar derecha")
					if Input.is_key_pressed(KEY_SHIFT):
						speed = 4
						animationPlayer.play("Andar derecha rapido")
					elif Input.is_key_pressed(KEY_SHIFT) == false:
						speed = 1
		else:
			move_to(get_pos() + direction * speed)
			if get_pos() == startPos + Vector2(direction.x * GRID, direction.y * GRID):
				moving = false

func _input(event):
	if event.type == InputEvent.KEY:
		if event.is_action_pressed("ui_interact"):
			if personaje.get_frame() == 12:
				interaccion(arriba)
			elif personaje.get_frame() == 0:
				interaccion(abajo)
			elif personaje.get_frame() == 4:
				interaccion(izquierda)
			elif personaje.get_frame() == 8:
				interaccion(derecha)
		elif event.is_action_pressed("ui_drop"):
			if personaje.get_frame() == 12:
				soltar(arriba)
			elif personaje.get_frame() == 0:
				soltar(abajo)
			elif personaje.get_frame() == 4:
				soltar(izquierda)
			elif personaje.get_frame() == 8:
				soltar(derecha)
#Esta función sirve para gestionar todo lo relacionado a las interacciones
#del personaje con distintos objetos del entorno
func interaccion(result):
	if result.empty():
		pass
	elif typeof(result[0].collider) == TYPE_OBJECT:
		if result[0].collider.has_node("EstanteInteraccion"):
			estanteJarras.coger_jarra()
		elif result[0].collider.has_node("BarrilCervezaInteraccion") or result[0].collider.has_node("BarrilVinoInteraccion"):
			barriles.interaccion_barril(result)
		elif result[0].collider.has_node("CajaCarneInteraccion") or result[0].collider.has_node("CajaPescadoInteraccion") or result[0].collider.has_node("CajaPanInteraccion") or result[0].collider.has_node("CajaHuevosInteraccion") or result[0].collider.has_node("CajaQuesoInteraccion") or result[0].collider.has_node("CajaVerdurasInteraccion") or result[0].collider.has_node("CajaPatatasInteraccion"):
			cajas.interaccion_caja(result)
		elif result[0].collider.has_node("CalderoInteraccion"):
			caldero.interaccion_caldero()
		#Esta parte gestiona la interracción con los clientes, y lo que
		#hace es que el personaje le entregue al cliente lo que tiene en las
		#manos, si es lo que ha pedido dicho cliente. Si no lo es, el juego
		#te informará a través de una notificación, diciendo que eso no es
		#lo que ha pedido
		elif result[0].collider.has_node("InteraccionCliente"):
			var lugar = result[0].collider.get_child(1).get_child(0).get_name()
			if get_parent().get_node("Navegacion").destinos[lugar].get_npc() != null:
				var npc = get_parent().get_node("Navegacion").destinos[lugar].get_npc().get_node("NPC")
				if personaje.get_child_count() == 1 and personaje.get_child(0).get_pos() == global.mano_derecha and personaje.get_child(0).get_filename() == npc.pedidoRuta and npc.get_child_count() == 5:
					var objeto = personaje.get_child(0)
					servir(npc, objeto, "derecha")
				elif personaje.get_child_count() == 1 and personaje.get_child(0).get_pos() == global.mano_izquierda and personaje.get_child(0).get_filename() == npc.pedidoRuta and npc.get_child_count() == 5:
					var objeto = personaje.get_child(0)
					servir(npc, objeto, "izquierda")
				elif personaje.get_child_count() == 2 and npc.get_child_count() == 5:
					if personaje.get_child(0).get_pos() == global.mano_derecha and personaje.get_child(0).get_filename() == npc.pedidoRuta:
						var objeto = personaje.get_child(0)
						servir(npc, objeto, "derecha")
					elif personaje.get_child(1).get_pos() == global.mano_derecha and personaje.get_child(1).get_filename() == npc.pedidoRuta:
						var objeto = personaje.get_child(1)
						servir(npc, objeto, "derecha")
					elif personaje.get_child(0).get_pos() == global.mano_izquierda and personaje.get_child(0).get_filename() == npc.pedidoRuta:
						var objeto = personaje.get_child(0)
						servir(npc, objeto, "izquierda")
					elif personaje.get_child(1).get_pos() == global.mano_izquierda and personaje.get_child(1).get_filename() == npc.pedidoRuta:
						var objeto = personaje.get_child(1)
						servir(npc, objeto, "izquierda")
				elif npc.get_child_count() > 5:
					notificaciones.notificaciones("Ya estoy servido")
				else:
					notificaciones.notificaciones("Esto no es lo que he pedido")
		#Esta parte gestiona la interracción con la papelera, y lo que
		#hace es que el personaje tire cualquier jarra con bebida que tenga
		#en las manos, ya que son los únicos items del juego que no se 
		#pueden devolver a su sitio
		elif result[0].collider.has_node("PapeleraInteraccion"):
			papelera.tirar_papelera()
#Esta función gestiona todo lo relacionado con las acciones de soltar objetos.
#Es parecida a la función de interacción, pero en lugar de coger los objetos
#los vuelve a dejar en su sitio
func soltar(result):
	if result.empty():
		pass
	elif typeof(result[0].collider) == TYPE_OBJECT:
		if result[0].collider.has_node("EstanteInteraccion"):
			estanteJarras.soltar_jarra()
		elif result[0].collider.has_node("CajaCarneInteraccion") or result[0].collider.has_node("CajaPescadoInteraccion") or result[0].collider.has_node("CajaPanInteraccion") or result[0].collider.has_node("CajaHuevosInteraccion") or result[0].collider.has_node("CajaQuesoInteraccion") or result[0].collider.has_node("CajaVerdurasInteraccion") or result[0].collider.has_node("CajaPatatasInteraccion"):
			cajas.dejar_alimento(result)
		elif result[0].collider.has_node("CalderoInteraccion"):
			caldero.dejar_comida()
#Esta función sirve para entregar un objeto a un npc
func servir(npc, objeto, mano):
	var pedido
	if mano == "derecha":
		if objeto.get_filename() == global.spriteVino.get_path():
			pedido = global.spriteVino.instance()
			global.instanciar_jarras("JarraVino")
		elif objeto.get_filename() == global.spriteCerveza.get_path():
			pedido = global.spriteCerveza.instance()
			global.instanciar_jarras("JarraCerveza")
		elif objeto.get_filename() == global.spritePan.get_path():
			pedido = global.spritePan.instance()
			global.instanciar_ingredientes(global.pan)
		elif objeto.get_filename() == global.spriteQueso.get_path():
			pedido = global.spriteQueso.instance()
			global.instanciar_ingredientes(global.queso)
		elif objeto.get_filename() == global.spriteCarneCocinada.get_path():
			pedido = global.instanciar_comida("CarneCocinada")
		elif objeto.get_filename() == global.spritePescadoCocinado.get_path():
			pedido = global.instanciar_comida("PescadoCocinado")
		elif objeto.get_filename() == global.spriteSopa.get_path():
			pedido = global.instanciar_comida("Sopa")
		elif objeto.get_filename() == global.spriteQuebrantos.get_path():
			pedido = global.instanciar_comida("Quebrantos")
		elif objeto.get_filename() == global.spriteOlla.get_path():
			pedido = global.instanciar_comida("Olla")
		elif objeto.get_filename() == global.spriteEstofado.get_path():
			pedido = global.instanciar_comida("Estofado")
	else:
		if objeto.get_filename() == global.spriteVino.get_path():
			pedido = global.spriteVino.instance()
			global.instanciar_jarras("JarraVino2")
		elif objeto.get_filename() == global.spriteCerveza.get_path():
			pedido = global.spriteCerveza.instance()
			global.instanciar_jarras("JarraCerveza2")
		elif objeto.get_filename() == global.spritePan.get_path():
			pedido = global.spritePan.instance()
			global.instanciar_ingredientes(global.pan2)
		elif objeto.get_filename() == global.spriteQueso.get_path():
			pedido = global.spriteQueso.instance()
			global.instanciar_ingredientes(global.queso2)
		elif objeto.get_filename() == global.spriteCarneCocinada.get_path():
			pedido = global.instanciar_comida("CarneCocinada2")
		elif objeto.get_filename() == global.spritePescadoCocinado.get_path():
			pedido = global.instanciar_comida("PescadoCocinado2")
		elif objeto.get_filename() == global.spriteSopa.get_path():
			pedido = global.instanciar_comida("Sopa2")
		elif objeto.get_filename() == global.spriteQuebrantos.get_path():
			pedido = global.instanciar_comida("Quebrantos2")
		elif objeto.get_filename() == global.spriteOlla.get_path():
			pedido = global.instanciar_comida("Olla2")
		elif objeto.get_filename() == global.spriteEstofado.get_path():
			pedido = global.instanciar_comida("Estofado2")
	objeto.queue_free()
	npc.add_child(pedido)
	npc.objeto = pedido
	pedido.set_pos(npc.get_node("Mano_derecha").get_pos())
	npc.get_parent().get_node("Pedido").hide()
	npc.beber_comer()