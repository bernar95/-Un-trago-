extends KinematicBody2D

var direction = Vector2(0,0)
var startPos = Vector2(0,0)
var moving = false
var cocina = false
var comidaCocinada = false
var mano_derecha = Vector2(8.841199, 5.105545)
var mano_izquierda= Vector2(-8.841199, 5.105545)
var pos_caldero = Vector2(592, 48)
var timer = Timer.new()
var timer2 = Timer.new()
var contadorCarne = 0
var contadorPescado = 0
var contadorVerduras = 0
var contadorPatatas = 0
var contadorHuevos = 0

var spriteJarra = preload("res://Scenes/Jarra.tscn")
var jarra = spriteJarra.instance()
var jarra2 = spriteJarra.instance()
var spriteCerveza = preload("res://Scenes/JarraCerveza.tscn")
var cerveza = spriteCerveza.instance()
var cerveza2 = spriteCerveza.instance()
var spriteVino = preload("res://Scenes/JarraVino.tscn")
var vino = spriteVino.instance()
var vino2 = spriteVino.instance()
var spriteCarne = preload("res://Scenes/carne.tscn")
var carne = spriteCarne.instance()
var carne2 = spriteCarne.instance()
var carne3 = spriteCarne.instance()
var spritePescado = preload("res://Scenes/pescado.tscn")
var pescado = spritePescado.instance()
var pescado2 = spritePescado.instance()
var pescado3 = spritePescado.instance()
var spriteVerduras = preload("res://Scenes/verduras.tscn")
var verdura = spriteVerduras.instance()
var verdura2 = spriteVerduras.instance()
var verdura3 = spriteVerduras.instance()
var spritePatatas = preload("res://Scenes/patatas.tscn")
var patata = spritePatatas.instance()
var patata2 = spritePatatas.instance()
var patata3 = spritePatatas.instance()
var spritePan = preload("res://Scenes/pan.tscn")
var pan = spritePan.instance()
var pan2 = spritePan.instance()
var pan3 = spritePan.instance()
var spriteQueso = preload("res://Scenes/queso.tscn")
var queso = spriteQueso.instance()
var queso2 = spriteQueso.instance()
var queso3 = spriteQueso.instance()
var spriteHuevos = preload("res://Scenes/huevos.tscn")
var huevo = spriteHuevos.instance()
var huevo2 = spriteHuevos.instance()
var huevo3 = spriteHuevos.instance()
var spriteCarneCocinada = preload("res://Scenes/carneCocinada.tscn")
var spritePescadoCocinado = preload("res://Scenes/pescadoCocinado.tscn")
var spriteQuebrantos = preload("res://Scenes/quebrantos.tscn")
var spriteOlla = preload("res://Scenes/olla.tscn")
var spriteSopa = preload("res://Scenes/sopa.tscn")
var spriteEstofado = preload("res://Scenes/estofado.tscn")

var spriteCaldero = preload("res://Scenes/Caldero.tscn")
var calderoAnimado = spriteCaldero.instance()

var personaje
var animationPlayer
var notificaciones 
var mapa
var caldero

var arriba
var abajo
var izquierda
var derecha

var speed = 1
const GRID = 16

func _ready():
	mapa = get_world_2d().get_direct_space_state()
	set_fixed_process(true)
	set_process_input(true)
	personaje = get_node("Personaje")
	animationPlayer = get_node("AnimationPlayer")
	notificaciones = get_parent().get_node("Hud/Notificaciones")
	caldero = get_parent().get_node("BarraDetras/Caldero")
	jarra.set_pos(mano_derecha)
	jarra2.set_pos(mano_izquierda)
	cerveza.set_pos(mano_derecha)
	cerveza2.set_pos(mano_izquierda)
	vino.set_pos(mano_derecha)
	vino2.set_pos(mano_izquierda)
	carne.set_pos(mano_derecha)
	carne2.set_pos(mano_izquierda)
	pescado.set_pos(mano_derecha)
	pescado2.set_pos(mano_izquierda)
	verdura.set_pos(mano_derecha)
	verdura2.set_pos(mano_izquierda)
	patata.set_pos(mano_derecha)
	patata2.set_pos(mano_izquierda)
	pan.set_pos(mano_derecha)
	pan2.set_pos(mano_izquierda)
	queso.set_pos(mano_derecha)
	queso2.set_pos(mano_izquierda)
	huevo.set_pos(mano_derecha)
	huevo2.set_pos(mano_izquierda)
	carne3.set_pos(Vector2(290, 42))
	pescado3.set_pos(Vector2(640, 42))
	verdura3.set_pos(Vector2(704, 42))
	patata3.set_pos(Vector2(736, 42))
	pan3.set_pos(Vector2(512, 26))
	queso3.set_pos(Vector2(672, 42))
	huevo3.set_pos(Vector2(544, 26))
	calderoAnimado.set_pos(pos_caldero)
	
	get_parent().get_node("Hud/Cocina").hide()
	get_parent().get_node("Hud/Raciones").hide()
	
func _fixed_process(delta):
	
	get_parent().get_node("Hud/Cocina").set_text(str(int(timer2.get_time_left())))
	get_parent().get_node("Hud/Raciones").set_text(str(caldero.get_child_count()) + " raciones")
	if caldero.get_child_count() == 0:
		get_parent().get_node("Hud/Raciones").hide()
		comidaCocinada = false
	for i in range(0, caldero.get_child_count()):
		if caldero.get_child(i).get_filename() == spriteCarneCocinada.get_path() or caldero.get_child(i).get_filename() == spritePescadoCocinado.get_path() or caldero.get_child(i).get_filename() == spriteQuebrantos.get_path() or caldero.get_child(i).get_filename() == spriteSopa.get_path() or caldero.get_child(i).get_filename() == spriteOlla.get_path() or caldero.get_child(i).get_filename() == spriteEstofado.get_path():
			get_parent().get_node("Hud/Raciones").show()
			comidaCocinada = true
	
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
	

func interaccion(result):
	if typeof(result[0].collider) == TYPE_OBJECT:
		if result[0].collider.has_node("EstanteInteraccion"):
			if personaje.get_child_count() == 0:
				personaje.add_child(jarra)
			elif personaje.get_child_count() == 1:
				if personaje.get_child(0).get_pos() == mano_derecha:
					personaje.add_child(jarra2)
				else:
					personaje.add_child(jarra)
			else:
				notificaciones("Tienes las manos ocupadas")
		elif result[0].collider.has_node("BarrilCervezaInteraccion") or result[0].collider.has_node("BarrilVinoInteraccion"):
			if personaje.get_child_count() == 0 or personaje.get_child_count() == 1 and personaje.get_child(0).get_filename() != spriteJarra.get_path() and personaje.get_child(0).get_filename() != spriteCerveza.get_path() and personaje.get_child(0).get_filename() != spriteVino.get_path() :
				notificaciones("Necesitas una jarra vacía")
			elif personaje.get_child_count() == 1:
				if personaje.get_child(0).get_filename() == spriteCerveza.get_path() or personaje.get_child(0).get_filename() == spriteVino.get_path():
					notificaciones("La jarra ya está llena")
				elif personaje.get_child(0).get_filename() == spriteJarra.get_path():
					if get_parent().get_node("Hud/Container").stock_cerveza == 0 and result[0].collider.has_node("BarrilCervezaInteraccion"):
						notificaciones("No tienes cerveza")
					elif get_parent().get_node("Hud/Container").stock_vino == 0 and result[0].collider.has_node("BarrilVinoInteraccion"):
						notificaciones("No tienes vino")
					elif get_parent().get_node("Hud/Container").stock_cerveza > 0 and result[0].collider.has_node("BarrilCervezaInteraccion"):
						if personaje.get_child(0).get_pos() == mano_derecha:
							rellenarJarra(cerveza, "0")
							instanciar_jarras("Jarra")
						else:
							rellenarJarra(cerveza2, "0")
							instanciar_jarras("Jarra2")
					elif get_parent().get_node("Hud/Container").stock_vino > 0 and result[0].collider.has_node("BarrilVinoInteraccion"):
						if personaje.get_child(0).get_pos() == mano_derecha:
							rellenarJarra(vino, "0")
							instanciar_jarras("Jarra")
						else:
							rellenarJarra(vino2, "0")
							instanciar_jarras("Jarra2")
			elif personaje.get_child_count() == 2:
				if personaje.get_child(0).get_filename() == spriteJarra.get_path() and personaje.get_child(1).get_filename() == spriteJarra.get_path():
					if get_parent().get_node("Hud/Container").stock_cerveza == 0 and result[0].collider.has_node("BarrilCervezaInteraccion"):
						notificaciones("No tienes cerveza")
					elif get_parent().get_node("Hud/Container").stock_vino == 0 and result[0].collider.has_node("BarrilVinoInteraccion"):
						notificaciones("No tienes vino")
					elif get_parent().get_node("Hud/Container").stock_cerveza == 1 and result[0].collider.has_node("BarrilCervezaInteraccion"):
						if personaje.get_child(0).get_pos() == mano_derecha:
							rellenarJarra(cerveza, "0")
							instanciar_jarras("Jarra")
						else:
							rellenarJarra(cerveza2, "0")
							instanciar_jarras("Jarra2")
						notificaciones("No tienes cerveza para ambas jarras")
					elif get_parent().get_node("Hud/Container").stock_vino == 1 and result[0].collider.has_node("BarrilVinoInteraccion"):
						if personaje.get_child(0).get_pos() == mano_derecha:
							rellenarJarra(vino, "0")
							instanciar_jarras("Jarra")
						else:
							rellenarJarra(vino2, "0")
							instanciar_jarras("Jarra2")
						notificaciones("No tienes vino para ambas jarras")
					elif get_parent().get_node("Hud/Container").stock_cerveza >= 2 and result[0].collider.has_node("BarrilCervezaInteraccion"):
						rellenarJarra(cerveza, "0")
						rellenarJarra(cerveza2, "0")
						instanciar_jarras("Jarra")
						instanciar_jarras("Jarra2")
					elif get_parent().get_node("Hud/Container").stock_vino >= 2 and result[0].collider.has_node("BarrilVinoInteraccion"):
						rellenarJarra(vino, "0")
						rellenarJarra(vino2, "0")
						instanciar_jarras("Jarra")
						instanciar_jarras("Jarra2")
				elif personaje.get_child(0).get_filename() == spriteCerveza.get_path() and personaje.get_child(1).get_filename() == spriteCerveza.get_path() or personaje.get_child(0).get_filename() == spriteVino.get_path() and personaje.get_child(1).get_filename() == spriteVino.get_path() or personaje.get_child(0).get_filename() == spriteVino.get_path() and personaje.get_child(1).get_filename() == spriteCerveza.get_path() or personaje.get_child(0).get_filename() == spriteCerveza.get_path() and personaje.get_child(1).get_filename() == spriteVino.get_path():
					notificaciones("Tienes las jarras llenas")
				elif personaje.get_child(0).get_filename() != spriteJarra.get_path() and personaje.get_child(1).get_filename() != spriteJarra.get_path():
					notificaciones("Necesitas una jarra vacía")
				else:
					if get_parent().get_node("Hud/Container").stock_cerveza > 0 and result[0].collider.has_node("BarrilCervezaInteraccion"):
						if personaje.get_child(0).get_filename() == spriteJarra.get_path():
							if personaje.get_child(0).get_pos() == mano_derecha:
								rellenarJarra(cerveza, "0")
								instanciar_jarras("Jarra")
							else:
								rellenarJarra(cerveza2, "0")
								instanciar_jarras("Jarra2")
						elif personaje.get_child(1).get_filename() == spriteJarra.get_path():
							if personaje.get_child(1).get_pos() == mano_derecha:
								rellenarJarra(cerveza, "1")
								instanciar_jarras("Jarra")
							else:
								rellenarJarra(cerveza2, "1")
								instanciar_jarras("Jarra2")
					elif get_parent().get_node("Hud/Container").stock_vino > 0 and result[0].collider.has_node("BarrilVinoInteraccion"):
						if personaje.get_child(0).get_filename() == spriteJarra.get_path():
							if personaje.get_child(0).get_pos() == mano_derecha:
								rellenarJarra(vino, "0")
								instanciar_jarras("Jarra")
							else:
								rellenarJarra(vino2, "0")
								instanciar_jarras("Jarra2")
						elif personaje.get_child(1).get_filename() == spriteJarra.get_path():
							if personaje.get_child(1).get_pos() == mano_derecha:
								rellenarJarra(vino, "1")
								instanciar_jarras("Jarra")
							else:
								rellenarJarra(vino2, "1")
								instanciar_jarras("Jarra2")
					elif get_parent().get_node("Hud/Container").stock_cerveza == 0 and result[0].collider.has_node("BarrilCervezaInteraccion"):
						notificaciones("No tienes cerveza")
					elif get_parent().get_node("Hud/Container").stock_vino == 0 and result[0].collider.has_node("BarrilVinoInteraccion"):
						notificaciones("No tienes vino")
		elif result[0].collider.has_node("CajaCarneInteraccion") or result[0].collider.has_node("CajaPescadoInteraccion") or result[0].collider.has_node("CajaPanInteraccion") or result[0].collider.has_node("CajaHuevosInteraccion") or result[0].collider.has_node("CajaQuesoInteraccion") or result[0].collider.has_node("CajaVerdurasInteraccion") or result[0].collider.has_node("CajaPatatasInteraccion"):
			if personaje.get_child_count() == 0:
				if get_parent().get_node("Hud/Container").stock_carne == 0 and result[0].collider.has_node("CajaCarneInteraccion"):
					notificaciones("No tienes carne")
				elif get_parent().get_node("Hud/Container").stock_pescado == 0 and result[0].collider.has_node("CajaPescadoInteraccion"):
					notificaciones("No tienes pescado")
				elif get_parent().get_node("Hud/Container").stock_verduras == 0 and result[0].collider.has_node("CajaVerdurasInteraccion"):
					notificaciones("No tienes verduras")
				elif get_parent().get_node("Hud/Container").stock_patatas == 0 and result[0].collider.has_node("CajaPatatasInteraccion"):
					notificaciones("No tienes patatas")
				elif get_parent().get_node("Hud/Container").stock_pan == 0 and result[0].collider.has_node("CajaPanInteraccion"):
					notificaciones("No tienes pan")
				elif get_parent().get_node("Hud/Container").stock_queso == 0 and result[0].collider.has_node("CajaQuesoInteraccion"):
					notificaciones("No tienes queso")
				elif get_parent().get_node("Hud/Container").stock_huevos == 0 and result[0].collider.has_node("CajaHuevosInteraccion"):
					notificaciones("No tienes huevos")
				elif get_parent().get_node("Hud/Container").stock_carne > 0 and result[0].collider.has_node("CajaCarneInteraccion"):
					cogerComida(carne)
					if get_parent().get_node("Hud/Container").stock_carne == 0:
						for i in range(0, get_parent().get_node("BarraDetras/Alimentos/Carne").get_child_count()):
							get_parent().get_node("BarraDetras/Alimentos/Carne").get_child(i).queue_free()
				elif get_parent().get_node("Hud/Container").stock_pescado > 0 and result[0].collider.has_node("CajaPescadoInteraccion"):
					cogerComida(pescado)
					if get_parent().get_node("Hud/Container").stock_pescado == 0:
						for i in range(0, get_parent().get_node("BarraDetras/Alimentos/Pescado").get_child_count()):
							get_parent().get_node("BarraDetras/Alimentos/Pescado").get_child(i).queue_free()
				elif get_parent().get_node("Hud/Container").stock_verduras > 0 and result[0].collider.has_node("CajaVerdurasInteraccion"):
					cogerComida(verdura)
					if get_parent().get_node("Hud/Container").stock_verduras == 0:
						for i in range(0, get_parent().get_node("BarraDetras/Alimentos/Verduras").get_child_count()):
							get_parent().get_node("BarraDetras/Alimentos/Verduras").get_child(i).queue_free()
				elif get_parent().get_node("Hud/Container").stock_patatas > 0 and result[0].collider.has_node("CajaPatatasInteraccion"):
					cogerComida(patata)
					if get_parent().get_node("Hud/Container").stock_patatas == 0:
						for i in range(0, get_parent().get_node("BarraDetras/Alimentos/Patatas").get_child_count()):
							get_parent().get_node("BarraDetras/Alimentos/Patatas").get_child(i).queue_free()
				elif get_parent().get_node("Hud/Container").stock_pan > 0 and result[0].collider.has_node("CajaPanInteraccion"):
					cogerComida(pan)
					if get_parent().get_node("Hud/Container").stock_pan == 0:
						for i in range(0, get_parent().get_node("BarraDetras/Alimentos/Pan").get_child_count()):
							get_parent().get_node("BarraDetras/Alimentos/Pan").get_child(i).queue_free()
				elif get_parent().get_node("Hud/Container").stock_queso > 0 and result[0].collider.has_node("CajaQuesoInteraccion"):
					cogerComida(queso)
					if get_parent().get_node("Hud/Container").stock_queso == 0:
						for i in range(0, get_parent().get_node("BarraDetras/Alimentos/Queso").get_child_count()):
							get_parent().get_node("BarraDetras/Alimentos/Queso").get_child(i).queue_free()
				elif get_parent().get_node("Hud/Container").stock_huevos > 0 and result[0].collider.has_node("CajaHuevosInteraccion"):
					cogerComida(huevo)
					if get_parent().get_node("Hud/Container").stock_huevos == 0:
						for i in range(0, get_parent().get_node("BarraDetras/Alimentos/Huevos").get_child_count()):
							get_parent().get_node("BarraDetras/Alimentos/Huevos").get_child(i).queue_free()
			elif personaje.get_child_count() == 1:
				if get_parent().get_node("Hud/Container").stock_carne == 0 and result[0].collider.has_node("CajaCarneInteraccion"):
					notificaciones("No tienes carne")
				elif get_parent().get_node("Hud/Container").stock_pescado == 0 and result[0].collider.has_node("CajaPescadoInteraccion"):
					notificaciones("No tienes pescado")
				elif get_parent().get_node("Hud/Container").stock_verduras == 0 and result[0].collider.has_node("CajaVerdurasInteraccion"):
					notificaciones("No tienes verduras")
				elif get_parent().get_node("Hud/Container").stock_patatas == 0 and result[0].collider.has_node("CajaPatatasInteraccion"):
					notificaciones("No tienes patatas")
				elif get_parent().get_node("Hud/Container").stock_pan == 0 and result[0].collider.has_node("CajaPanInteraccion"):
					notificaciones("No tienes pan")
				elif get_parent().get_node("Hud/Container").stock_queso == 0 and result[0].collider.has_node("CajaQuesoInteraccion"):
					notificaciones("No tienes queso")
				elif get_parent().get_node("Hud/Container").stock_huevos == 0 and result[0].collider.has_node("CajaHuevosInteraccion"):
					notificaciones("No tienes huevos")
				elif get_parent().get_node("Hud/Container").stock_carne > 0 and result[0].collider.has_node("CajaCarneInteraccion"):
					if personaje.get_child(0).get_pos() == mano_derecha:
						cogerComida(carne2)
					else:
						cogerComida(carne)
					if get_parent().get_node("Hud/Container").stock_carne == 0:
						for i in range(0, get_parent().get_node("BarraDetras/Alimentos/Carne").get_child_count()):
							get_parent().get_node("BarraDetras/Alimentos/Carne").get_child(i).queue_free()
				elif get_parent().get_node("Hud/Container").stock_pescado > 0 and result[0].collider.has_node("CajaPescadoInteraccion"):
					if personaje.get_child(0).get_pos() == mano_derecha:
						cogerComida(pescado2)
					else:
						cogerComida(pescado)
					if get_parent().get_node("Hud/Container").stock_pescado == 0:
						for i in range(0, get_parent().get_node("BarraDetras/Alimentos/Pescado").get_child_count()):
							get_parent().get_node("BarraDetras/Alimentos/Pescado").get_child(i).queue_free()
				elif get_parent().get_node("Hud/Container").stock_verduras > 0 and result[0].collider.has_node("CajaVerdurasInteraccion"):
					if personaje.get_child(0).get_pos() == mano_derecha:
						cogerComida(verdura2)
					else:
						cogerComida(verdura)
					if get_parent().get_node("Hud/Container").stock_verduras == 0:
						for i in range(0, get_parent().get_node("BarraDetras/Alimentos/Verduras").get_child_count()):
							get_parent().get_node("BarraDetras/Alimentos/Verduras").get_child(i).queue_free()
				elif get_parent().get_node("Hud/Container").stock_patatas > 0 and result[0].collider.has_node("CajaPatatasInteraccion"):
					if personaje.get_child(0).get_pos() == mano_derecha:
						cogerComida(patata2)
					else:
						cogerComida(patata)
					if get_parent().get_node("Hud/Container").stock_patatas == 0:
						for i in range(0, get_parent().get_node("BarraDetras/Alimentos/Patatas").get_child_count()):
							get_parent().get_node("BarraDetras/Alimentos/Patatas").get_child(i).queue_free()
				elif get_parent().get_node("Hud/Container").stock_pan > 0 and result[0].collider.has_node("CajaPanInteraccion"):
					if personaje.get_child(0).get_pos() == mano_derecha:
						cogerComida(pan2)
					else:
						cogerComida(pan)
					if get_parent().get_node("Hud/Container").stock_pan == 0:
						for i in range(0, get_parent().get_node("BarraDetras/Alimentos/Pan").get_child_count()):
							get_parent().get_node("BarraDetras/Alimentos/Pan").get_child(i).queue_free()
				elif get_parent().get_node("Hud/Container").stock_queso > 0 and result[0].collider.has_node("CajaQuesoInteraccion"):
					if personaje.get_child(0).get_pos() == mano_derecha:
						cogerComida(queso2)
					else:
						cogerComida(queso)
					if get_parent().get_node("Hud/Container").stock_queso == 0:
						for i in range(0, get_parent().get_node("BarraDetras/Alimentos/Queso").get_child_count()):
							get_parent().get_node("BarraDetras/Alimentos/Queso").get_child(i).queue_free()
				elif get_parent().get_node("Hud/Container").stock_huevos > 0 and result[0].collider.has_node("CajaHuevosInteraccion"):
					if personaje.get_child(0).get_pos() == mano_derecha:
						cogerComida(huevo2)
					else:
						cogerComida(huevo)
					if get_parent().get_node("Hud/Container").stock_huevos == 0:
						for i in range(0, get_parent().get_node("BarraDetras/Alimentos/Huevos").get_child_count()):
							get_parent().get_node("BarraDetras/Alimentos/Huevos").get_child(i).queue_free()
			elif personaje.get_child_count() == 2:
				notificaciones("Tienes las manos ocupadas")
		elif result[0].collider.has_node("CalderoInteraccion"):
			if personaje.get_child_count() == 0:
				if caldero.get_child_count() == 0 and cocina == false:
					notificaciones("Necesitas ingredientes")
				elif caldero.get_child_count() > 0:
					if contadorCarne == 1 and caldero.get_child_count() == 1:
						timer2.set_wait_time(5)
						cocina("Carne cocinada")
					elif caldero.get_child(0).get_filename() == spriteCarneCocinada.get_path():
						cogerComidaCocinada("Carne", "Derecha")
					elif contadorPescado == 1 and caldero.get_child_count() == 1:
						timer2.set_wait_time(5)
						cocina("Pescado cocinado")
					elif caldero.get_child(0).get_filename() == spritePescadoCocinado.get_path():
						cogerComidaCocinada("Pescado", "Derecha")
					elif contadorCarne == 1 and contadorHuevos == 2:
						timer2.set_wait_time(5)
						cocina("Quebrantos")
					elif caldero.get_child(0).get_filename() == spriteQuebrantos.get_path():
						cogerComidaCocinada("Quebrantos", "Derecha")
					elif contadorPatatas == 5 and contadorVerduras == 5:
						timer2.set_wait_time(5)
						cocina("Sopa")
					elif caldero.get_child(0).get_filename() == spriteSopa.get_path():
						cogerComidaCocinada("Sopa", "Derecha")
					elif contadorVerduras == 5 and contadorCarne == 5:
						timer2.set_wait_time(5)
						cocina("Olla")
					elif caldero.get_child(0).get_filename() == spriteOlla.get_path():
						cogerComidaCocinada("Olla", "Derecha")
					elif contadorPatatas == 5 and contadorCarne == 5:
						timer2.set_wait_time(5)
						cocina("Estofado")
					elif caldero.get_child(0).get_filename() == spriteEstofado.get_path():
						cogerComidaCocinada("Estofado", "Derecha")
					else:
						notificaciones("La comida se desperdició")
						for i in range(0, caldero.get_child_count()):
							caldero.get_child(i).queue_free()
				else:
					notificaciones("Aún no ha terminado")
		
			elif personaje.get_child_count() == 1:
				if cocina == false:
					if comidaCocinada == false:
						if personaje.get_child(0).get_filename() == spriteCarne.get_path():
							if personaje.get_child(0).get_pos() == mano_derecha:
								echarIngrediente(carne)
								instanciar_ingredientes(carne)
							else:
								echarIngrediente(carne2)
								instanciar_ingredientes(carne2)
							notificaciones("Has añadido carne")
							contadorCarne += 1
						elif personaje.get_child(0).get_filename() == spritePescado.get_path():
							if personaje.get_child(0).get_pos() == mano_derecha:
								echarIngrediente(pescado)
								instanciar_ingredientes(pescado)
							else:
								echarIngrediente(pescado2)
								instanciar_ingredientes(pescado2)
							notificaciones("Has añadido pescado")
							contadorPescado += 1
						elif personaje.get_child(0).get_filename() == spriteVerduras.get_path():
							if personaje.get_child(0).get_pos() == mano_derecha:
								echarIngrediente(verdura)
								instanciar_ingredientes(verdura)
							else:
								echarIngrediente(verdura2)
								instanciar_ingredientes(verdura2)
							notificaciones("Has añadido verdura")
							contadorVerduras += 1
						elif personaje.get_child(0).get_filename() == spritePatatas.get_path():
							if personaje.get_child(0).get_pos() == mano_derecha:
								echarIngrediente(patata)
								instanciar_ingredientes(patata)
							else:
								echarIngrediente(patata2)
								instanciar_ingredientes(patata2)
							notificaciones("Has añadido una patata")
							contadorPatatas += 1
						elif personaje.get_child(0).get_filename() == spriteHuevos.get_path():
							if personaje.get_child(0).get_pos() == mano_derecha:
								echarIngrediente(huevo)
								instanciar_ingredientes(huevo)
							else:
								echarIngrediente(huevo2)
								instanciar_ingredientes(huevo2)
							notificaciones("Has añadido un huevo")
							contadorHuevos += 1
						else:
							notificaciones("No puedes añadir esto")
					else:
						if caldero.get_child_count() > 0 and contadorCarne == 0 and contadorPescado == 0 and contadorVerduras == 0 and contadorPatatas == 0 and contadorHuevos == 0:
							if caldero.get_child(0).get_filename() == spriteCarneCocinada.get_path() and personaje.get_child(0).get_pos() == mano_derecha:
								cogerComidaCocinada("Carne", "Izquierda")
							elif caldero.get_child(0).get_filename() == spriteCarneCocinada.get_path() and personaje.get_child(0).get_pos() == mano_izquierda:
								cogerComidaCocinada("Carne", "Derecha")
							elif caldero.get_child(0).get_filename() == spritePescadoCocinado.get_path() and personaje.get_child(0).get_pos() == mano_derecha:
								cogerComidaCocinada("Pescado", "Izquierda")
							elif caldero.get_child(0).get_filename() == spritePescadoCocinado.get_path() and personaje.get_child(0).get_pos() == mano_izquierda:
								cogerComidaCocinada("Pescado", "Derecha")
							elif caldero.get_child(0).get_filename() == spriteQuebrantos.get_path() and personaje.get_child(0).get_pos() == mano_derecha:
								cogerComidaCocinada("Quebrantos", "Izquierda")
							elif caldero.get_child(0).get_filename() == spriteQuebrantos.get_path() and personaje.get_child(0).get_pos() == mano_izquierda:
								cogerComidaCocinada("Quebrantos", "Derecha")
							elif caldero.get_child(0).get_filename() == spriteSopa.get_path() and personaje.get_child(0).get_pos() == mano_derecha:
								cogerComidaCocinada("Sopa", "Izquierda")
							elif caldero.get_child(0).get_filename() == spriteSopa.get_path() and personaje.get_child(0).get_pos() == mano_izquierda:
								cogerComidaCocinada("Sopa", "Derecha")
							elif caldero.get_child(0).get_filename() == spriteOlla.get_path() and personaje.get_child(0).get_pos() == mano_derecha:
								cogerComidaCocinada("Olla", "Izquierda")
							elif caldero.get_child(0).get_filename() == spriteOlla.get_path() and personaje.get_child(0).get_pos() == mano_izquierda:
								cogerComidaCocinada("Olla", "Derecha")
							elif caldero.get_child(0).get_filename() == spriteEstofado.get_path() and personaje.get_child(0).get_pos() == mano_derecha:
								cogerComidaCocinada("Estofado", "Izquierda")
							elif caldero.get_child(0).get_filename() == spriteEstofado.get_path() and personaje.get_child(0).get_pos() == mano_izquierda:
								cogerComidaCocinada("Estofado", "Derecha")
				else:
					notificaciones("Aun no ha terminado")
			elif personaje.get_child_count() == 2:
				if cocina == false:
					if comidaCocinada == false:
						if personaje.get_child(0).get_filename() == spriteCarne.get_path() and personaje.get_child(1).get_filename() == spriteCarne.get_path() :
							echarIngrediente(carne)
							echarIngrediente(carne2)
							notificaciones("Has añadido dos de carne")
							contadorCarne += 2
							instanciar_ingredientes(carne)
							instanciar_ingredientes(carne2)
						elif personaje.get_child(0).get_filename() == spritePescado.get_path() and personaje.get_child(1).get_filename() == spritePescado.get_path() :
							echarIngrediente(pescado)
							echarIngrediente(pescado2)
							notificaciones("Has añadido dos peces")
							contadorPescado += 2
							instanciar_ingredientes(pescado)
							instanciar_ingredientes(pescado2)
						elif personaje.get_child(0).get_filename() == spriteVerduras.get_path() and personaje.get_child(1).get_filename() == spriteVerduras.get_path() :
							echarIngrediente(verdura)
							echarIngrediente(verdura2)
							notificaciones("Has añadido dos verduras")
							contadorVerduras += 2
							instanciar_ingredientes(verdura)
							instanciar_ingredientes(verdura2)
						elif personaje.get_child(0).get_filename() == spritePatatas.get_path() and personaje.get_child(1).get_filename() == spritePatatas.get_path() :
							echarIngrediente(patata)
							echarIngrediente(patata2)
							notificaciones("Has añadido dos patatas")
							contadorPatatas += 2
							instanciar_ingredientes(patata)
							instanciar_ingredientes(patata2)
						elif personaje.get_child(0).get_filename() == spriteHuevos.get_path() and personaje.get_child(1).get_filename() == spriteHuevos.get_path() :
							echarIngrediente(huevo)
							echarIngrediente(huevo2)
							notificaciones("Has añadido dos huevos")
							contadorHuevos += 2
							instanciar_ingredientes(huevo)
							instanciar_ingredientes(huevo2)
						elif personaje.get_child(0).get_filename() == spriteHuevos.get_path() and personaje.get_child(1).get_filename() == spriteCarne.get_path():
							echarIngrediente(huevo)
							echarIngrediente(carne2)
							notificaciones("Has añadido carne y un huevo")
							contadorHuevos += 1
							contadorCarne += 1
							instanciar_ingredientes(huevo)
							instanciar_ingredientes(carne2)
						elif personaje.get_child(0).get_filename() == spriteCarne.get_path() and personaje.get_child(1).get_filename() == spriteHuevos.get_path():
							echarIngrediente(carne)
							echarIngrediente(huevo2)
							notificaciones("Has añadido carne y un huevo")
							contadorHuevos += 1
							contadorCarne += 1
							instanciar_ingredientes(carne)
							instanciar_ingredientes(huevo2)
						elif personaje.get_child(0).get_filename() == spriteCarne.get_path() and personaje.get_child(1).get_filename() == spriteVerduras.get_path():
							echarIngrediente(carne)
							echarIngrediente(verdura2)
							notificaciones("Has añadido carne y verdura")
							contadorVerduras += 1
							contadorCarne += 1
							instanciar_ingredientes(carne)
							instanciar_ingredientes(verdura2)
						elif personaje.get_child(0).get_filename() == spriteVerduras.get_path() and personaje.get_child(1).get_filename() == spriteCarne.get_path():
							echarIngrediente(carne2)
							echarIngrediente(verdura)
							notificaciones("Has añadido carne y verdura")
							contadorVerduras += 1
							contadorCarne += 1
							instanciar_ingredientes(verdura)
							instanciar_ingredientes(carne2)
						elif personaje.get_child(0).get_filename() == spritePatatas.get_path() and personaje.get_child(1).get_filename() == spriteCarne.get_path():
							echarIngrediente(carne2)
							echarIngrediente(patata)
							notificaciones("Has añadido carne y una patata")
							contadorPatatas += 1
							contadorCarne += 1
							instanciar_ingredientes(patata)
							instanciar_ingredientes(carne2)
						elif personaje.get_child(0).get_filename() == spriteCarne.get_path() and personaje.get_child(1).get_filename() == spritePatatas.get_path():
							echarIngrediente(carne)
							echarIngrediente(patata2)
							notificaciones("Has añadido carne y una patata")
							contadorPatatas += 1
							contadorCarne += 1
							instanciar_ingredientes(carne)
							instanciar_ingredientes(patata2)
						elif personaje.get_child(0).get_filename() == spriteVerduras.get_path() and personaje.get_child(1).get_filename() == spritePatatas.get_path():
							echarIngrediente(verdura)
							echarIngrediente(patata2)
							notificaciones("Has añadido verdura y una patata")
							contadorPatatas += 1
							contadorVerduras += 1
							instanciar_ingredientes(verdura)
							instanciar_ingredientes(patata2)
						elif personaje.get_child(0).get_filename() == spritePatatas.get_path() and personaje.get_child(1).get_filename() == spriteVerduras.get_path():
							echarIngrediente(verdura2)
							echarIngrediente(patata)
							notificaciones("Has añadido verdura y una patata")
							contadorPatatas += 1
							contadorVerduras += 1
							instanciar_ingredientes(patata)
							instanciar_ingredientes(verdura2)
						elif personaje.get_child(0).get_filename() == spriteCarne.get_path() :
							if personaje.get_child(0).get_pos() == mano_derecha:
								echarIngrediente(carne)
								instanciar_ingredientes(carne)
							else:
								echarIngrediente(carne2)
								instanciar_ingredientes(carne2)
							notificaciones("Has añadido carne")
							contadorCarne += 1
							
						elif personaje.get_child(1).get_filename() == spriteCarne.get_path() :
							if personaje.get_child(1).get_pos() == mano_derecha:
								echarIngrediente(carne)
								instanciar_ingredientes(carne)
							else:
								echarIngrediente(carne2)
								instanciar_ingredientes(carne2)
							notificaciones("Has añadido carne")
							contadorCarne += 1
						elif personaje.get_child(0).get_filename() == spriteVerduras.get_path() :
							if personaje.get_child(0).get_pos() == mano_derecha:
								echarIngrediente(verdura)
								instanciar_ingredientes(verdura)
							else:
								echarIngrediente(verdura2)
								instanciar_ingredientes(verdura2)
							notificaciones("Has añadido verdura")
							contadorVerduras += 1
						elif personaje.get_child(1).get_filename() == spriteVerduras.get_path() :
							if personaje.get_child(1).get_pos() == mano_derecha:
								echarIngrediente(verdura)
								instanciar_ingredientes(verdura)
							else:
								echarIngrediente(verdura2)
								instanciar_ingredientes(verdura2)
							notificaciones("Has añadido verdura")
							contadorVerduras += 1
						elif personaje.get_child(0).get_filename() == spritePatatas.get_path() :
							if personaje.get_child(0).get_pos() == mano_derecha:
								echarIngrediente(patata)
								instanciar_ingredientes(patata)
							else:
								echarIngrediente(patata2)
								instanciar_ingredientes(patata2)
							notificaciones("Has añadido una patata")
							contadorPatatas += 1
						elif personaje.get_child(1).get_filename() == spritePatatas.get_path() :
							if personaje.get_child(1).get_pos() == mano_derecha:
								echarIngrediente(patata)
								instanciar_ingredientes(patata)
							else:
								echarIngrediente(patata2)
								instanciar_ingredientes(patata2)
							notificaciones("Has añadido una patata")
							contadorPatatas += 1
						elif personaje.get_child(0).get_filename() == spriteHuevos.get_path() :
							if personaje.get_child(0).get_pos() == mano_derecha:
								echarIngrediente(huevo)
								instanciar_ingredientes(huevo)
							else:
								echarIngrediente(huevo2)
								instanciar_ingredientes(huevo2)
							notificaciones("Has añadido un huevo")
							contadorHuevos += 1
						elif personaje.get_child(1).get_filename() == spriteHuevos.get_path() :
							if personaje.get_child(1).get_pos() == mano_derecha:
								echarIngrediente(huevo)
								instanciar_ingredientes(huevo)
							else:
								echarIngrediente(huevo2)
								instanciar_ingredientes(huevo2)
							notificaciones("Has añadido un huevo")
							contadorHuevos += 1
						elif personaje.get_child(0).get_filename() == spritePescado.get_path() :
							if personaje.get_child(0).get_pos() == mano_derecha:
								echarIngrediente(pescado)
								instanciar_ingredientes(pescado)
							else:
								echarIngrediente(pescado2)
								instanciar_ingredientes(pescado2)
							notificaciones("Has añadido un pescado")
							contadorPescado += 1
						elif personaje.get_child(1).get_filename() == spritePescado.get_path() :
							if personaje.get_child(1).get_pos() == mano_derecha:
								echarIngrediente(pescado)
								instanciar_ingredientes(pescado)
							else:
								echarIngrediente(pescado2)
								instanciar_ingredientes(pescado2)
							notificaciones("Has añadido un pescado")
							contadorPescado += 1
						else:
							notificaciones("No puedes añadir esto")
					else:
						notificaciones("Tienes las manos ocupadas")
				else:
					notificaciones("Aun no ha terminado")

func soltar(result):
	if typeof(result[0].collider) == TYPE_OBJECT:
		if result[0].collider.has_node("EstanteInteraccion"):
			if personaje.get_child_count() == 0:
				notificaciones("No tienes nada que soltar")
			elif (personaje.get_child_count() == 1 or personaje.get_child_count() == 2) and personaje.get_child(0).get_filename() == spriteJarra.get_path():
				if personaje.get_child(0).get_pos() == mano_derecha:
					personaje.get_child(0).free()
					instanciar_jarras("Jarra")
				else:
					personaje.get_child(0).free()
					instanciar_jarras("Jarra2")
			elif personaje.get_child_count() == 2 and personaje.get_child(1).get_filename() == spriteJarra.get_path():
				if personaje.get_child(1).get_pos() == mano_derecha:
					personaje.get_child(1).free()
					instanciar_jarras("Jarra")
				else:
					personaje.get_child(1).free()
					instanciar_jarras("Jarra2")
			else:
				notificaciones("Esto no va aquí")
		elif result[0].collider.has_node("CajaCarneInteraccion") or result[0].collider.has_node("CajaPescadoInteraccion") or result[0].collider.has_node("CajaPanInteraccion") or result[0].collider.has_node("CajaHuevosInteraccion") or result[0].collider.has_node("CajaQuesoInteraccion") or result[0].collider.has_node("CajaVerdurasInteraccion") or result[0].collider.has_node("CajaPatatasInteraccion"):
			if personaje.get_child_count() == 0:
				notificaciones("No tienes nada que soltar")
			elif (personaje.get_child_count() == 1 or personaje.get_child_count() == 2) and result[0].collider.has_node("CajaCarneInteraccion") and personaje.get_child(0).get_filename() == spriteCarne.get_path():
				if personaje.get_child(0).get_pos() == mano_derecha:
					dejarComida("Carne", "0")
					instanciar_ingredientes(carne)
				else:
					dejarComida("Carne", "0")
					instanciar_ingredientes(carne2)
				if get_parent().get_node("BarraDetras/Alimentos/Carne").get_child_count() == 0:
					instanciar_ingredientes(carne3)
			elif (personaje.get_child_count() == 1 or personaje.get_child_count() == 2) and result[0].collider.has_node("CajaPescadoInteraccion") and personaje.get_child(0).get_filename() == spritePescado.get_path():
				if personaje.get_child(0).get_pos() == mano_derecha:
					dejarComida("Pescado", "0")
					instanciar_ingredientes(pescado)
				else:
					dejarComida("Pescado", "0")
					instanciar_ingredientes(pescado2)
				if get_parent().get_node("BarraDetras/Alimentos/Pescado").get_child_count() == 0:
					instanciar_ingredientes(pescado3)
			elif (personaje.get_child_count() == 1 or personaje.get_child_count() == 2) and result[0].collider.has_node("CajaVerdurasInteraccion") and personaje.get_child(0).get_filename() == spriteVerduras.get_path():
				if personaje.get_child(0).get_pos() == mano_derecha:
					dejarComida("Verdura", "0")
					instanciar_ingredientes(verdura)
				else:
					dejarComida("Verdura", "0")
					instanciar_ingredientes(verdura2)
				if get_parent().get_node("BarraDetras/Alimentos/Verduras").get_child_count() == 0:
					instanciar_ingredientes(verdura3)
			elif (personaje.get_child_count() == 1 or personaje.get_child_count() == 2) and result[0].collider.has_node("CajaPatatasInteraccion") and personaje.get_child(0).get_filename() == spritePatatas.get_path():
				if personaje.get_child(0).get_pos() == mano_derecha:
					dejarComida("Patata", "0")
					instanciar_ingredientes(patata)
				else:
					dejarComida("Patata", "0")
					instanciar_ingredientes(patata2)
				if get_parent().get_node("BarraDetras/Alimentos/Patatas").get_child_count() == 0:
					instanciar_ingredientes(patata3)
			elif (personaje.get_child_count() == 1 or personaje.get_child_count() == 2) and result[0].collider.has_node("CajaPanInteraccion") and personaje.get_child(0).get_filename() == spritePan.get_path():
				if personaje.get_child(0).get_pos() == mano_derecha:
					dejarComida("Pan", "0")
					instanciar_ingredientes(pan)
				else:
					dejarComida("Pan", "0")
					instanciar_ingredientes(pan2)
				if get_parent().get_node("BarraDetras/Alimentos/Pan").get_child_count() == 0:
					instanciar_ingredientes(pan3)
			elif (personaje.get_child_count() == 1 or personaje.get_child_count() == 2) and result[0].collider.has_node("CajaQuesoInteraccion") and personaje.get_child(0).get_filename() == spriteQueso.get_path():
				if personaje.get_child(0).get_pos() == mano_derecha:
					dejarComida("Queso", "0")
					instanciar_ingredientes(queso)
				else:
					dejarComida("Queso", "0")
					instanciar_ingredientes(queso2)
				if get_parent().get_node("BarraDetras/Alimentos/Queso").get_child_count() == 0:
					instanciar_ingredientes(queso3)
			elif (personaje.get_child_count() == 1 or personaje.get_child_count() == 2) and result[0].collider.has_node("CajaHuevosInteraccion") and personaje.get_child(0).get_filename() == spriteHuevos.get_path():
				if personaje.get_child(0).get_pos() == mano_derecha:
					dejarComida("Huevo", "0")
					instanciar_ingredientes(huevo)
				else:
					dejarComida("Huevo", "0")
					instanciar_ingredientes(huevo2)
				if get_parent().get_node("BarraDetras/Alimentos/Huevos").get_child_count() == 0:
					instanciar_ingredientes(huevo3)
			elif personaje.get_child_count() == 2 and result[0].collider.has_node("CajaCarneInteraccion") and personaje.get_child(1).get_filename() == spriteCarne.get_path():
				if personaje.get_child(1).get_pos() == mano_derecha:
					dejarComida("Carne", "1")
					instanciar_ingredientes(carne)
				else:
					dejarComida("Carne", "1")
					instanciar_ingredientes(carne2)
				if get_parent().get_node("BarraDetras/Alimentos/Carne").get_child_count() == 0:
					instanciar_ingredientes(carne3)
			elif personaje.get_child_count() == 2 and result[0].collider.has_node("CajaPescadoInteraccion") and personaje.get_child(1).get_filename() == spritePescado.get_path():
				if personaje.get_child(1).get_pos() == mano_derecha:
					dejarComida("Pescado", "1")
					instanciar_ingredientes(pescado)
				else:
					dejarComida("Pescado", "1")
					instanciar_ingredientes(pescado2)
				if get_parent().get_node("BarraDetras/Alimentos/Pescado").get_child_count() == 0:
					instanciar_ingredientes(pescado3)
			elif personaje.get_child_count() == 2 and result[0].collider.has_node("CajaVerdurasInteraccion") and personaje.get_child(1).get_filename() == spriteVerduras.get_path():
				if personaje.get_child(1).get_pos() == mano_derecha:
					dejarComida("Verdura", "1")
					instanciar_ingredientes(verdura)
				else:
					dejarComida("Verdura", "1")
					instanciar_ingredientes(verdura2)
				if get_parent().get_node("BarraDetras/Alimentos/Verduras").get_child_count() == 0:
					instanciar_ingredientes(verdura3)
			elif personaje.get_child_count() == 2 and result[0].collider.has_node("CajaPatatasInteraccion") and personaje.get_child(1).get_filename() == spritePatatas.get_path():
				if personaje.get_child(1).get_pos() == mano_derecha:
					dejarComida("Patata", "1")
					instanciar_ingredientes(patata)
				else:
					dejarComida("Patata", "1")
					instanciar_ingredientes(patata2)
				if get_parent().get_node("BarraDetras/Alimentos/Patatas").get_child_count() == 0:
					instanciar_ingredientes(patata3)
			elif personaje.get_child_count() == 2 and result[0].collider.has_node("CajaPanInteraccion") and personaje.get_child(1).get_filename() == spritePan.get_path():
				if personaje.get_child(1).get_pos() == mano_derecha:
					dejarComida("Pan", "1")
					instanciar_ingredientes(pan)
				else:
					dejarComida("Pan", "1")
					instanciar_ingredientes(pan)
				if get_parent().get_node("BarraDetras/Alimentos/Pan").get_child_count() == 0:
					instanciar_ingredientes(pan3)
			elif personaje.get_child_count() == 2 and result[0].collider.has_node("CajaQuesoInteraccion") and personaje.get_child(1).get_filename() == spriteQueso.get_path():
				if personaje.get_child(1).get_pos() == mano_derecha:
					dejarComida("Queso", "1")
					instanciar_ingredientes(queso)
				else:
					dejarComida("Queso", "1")
					instanciar_ingredientes(queso2)
				if get_parent().get_node("BarraDetras/Alimentos/Queso").get_child_count() == 0:
					instanciar_ingredientes(queso3)
			elif personaje.get_child_count() == 2 and result[0].collider.has_node("CajaHuevosInteraccion") and personaje.get_child(1).get_filename() == spriteHuevos.get_path():
				if personaje.get_child(1).get_pos() == mano_derecha:
					dejarComida("Huevo", "1")
					instanciar_ingredientes(huevo)
				else:
					dejarComida("Huevo", "1")
					instanciar_ingredientes(huevo2)
				if get_parent().get_node("BarraDetras/Alimentos/Huevos").get_child_count() == 0:
					instanciar_ingredientes(huevo3)
			else:
				notificaciones("Esto no va aquí")
		elif result[0].collider.has_node("CalderoInteraccion"):
			if personaje.get_child_count() == 0:
				notificaciones("No tienes nada que soltar")
			elif (personaje.get_child_count() == 1 or personaje.get_child_count() == 2) and personaje.get_child(0).get_filename() == spriteCarneCocinada.get_path():
				dejarComida("Carne cocinada", "0")
			elif (personaje.get_child_count() == 1 or personaje.get_child_count() == 2) and personaje.get_child(0).get_filename() == spritePescadoCocinado.get_path():
				dejarComida("Pescado cocinado", "0")
			elif (personaje.get_child_count() == 1 or personaje.get_child_count() == 2) and personaje.get_child(0).get_filename() == spriteQuebrantos.get_path():
				dejarComida("Quebrantos", "0")
			elif (personaje.get_child_count() == 1 or personaje.get_child_count() == 2) and personaje.get_child(0).get_filename() == spriteSopa.get_path():
				dejarComida("Sopa", "0")
			elif (personaje.get_child_count() == 1 or personaje.get_child_count() == 2) and personaje.get_child(0).get_filename() == spriteOlla.get_path():
				dejarComida("Olla", "0")
			elif (personaje.get_child_count() == 1 or personaje.get_child_count() == 2) and personaje.get_child(0).get_filename() == spriteEstofado.get_path():
				dejarComida("Estofado", "0")
			elif  personaje.get_child_count() == 2 and personaje.get_child(1).get_filename() == spriteCarneCocinada.get_path():
				dejarComida("Carne cocinada", "1")
			elif personaje.get_child_count() == 2 and personaje.get_child(1).get_filename() == spritePescadoCocinado.get_path():
				dejarComida("Pescado cocinado", "1")
			elif personaje.get_child_count() == 2 and personaje.get_child(1).get_filename() == spriteQuebrantos.get_path():
				dejarComida("Quebrantos", "1")
			elif personaje.get_child_count() == 2 and personaje.get_child(1).get_filename() == spriteSopa.get_path():
				dejarComida("Sopa", "1")
			elif personaje.get_child_count() == 2 and personaje.get_child(1).get_filename() == spriteOlla.get_path():
				dejarComida("Olla", "1")
			elif personaje.get_child_count() == 2 and personaje.get_child(1).get_filename() == spriteEstofado.get_path():
				dejarComida("Estofado", "1")
			else:
				notificaciones("Esto no va aquí")

func notificaciones(text):
	notificaciones.show()
	get_parent().get_node("Hud/Cerrar").show()
	notificaciones.get_node("Notificacion").set_text(text)
	timer.set_wait_time(10)
	timer.set_one_shot(true)
	self.add_child(timer)
	timer.start()
	yield(timer, "timeout")
	notificaciones.hide()
	get_parent().get_node("Hud/Cerrar").hide()

func rellenarJarra(bebida, hijo):
	if hijo == "0":
		personaje.get_child(0).free()
	elif hijo == "1":
		personaje.get_child(1).free()
	personaje.add_child(bebida)

	if bebida == cerveza or bebida == cerveza2:
		get_parent().get_node("Hud/Container").stock_cerveza -= 1
		var text = str(get_parent().get_node("Hud/Container").stock_cerveza) + "/90"
		get_parent().get_node("Hud/LibroSuministros/ContainerCerveza/StockCerveza").set_text(text)
	elif bebida == vino or bebida == vino2:
		get_parent().get_node("Hud/Container").stock_vino -= 1
		var text = str(get_parent().get_node("Hud/Container").stock_vino) + "/90"
		get_parent().get_node("Hud/LibroSuministros/ContainerVino/StockVino").set_text(text)

func cogerComida(comida):
	personaje.add_child(comida)
	if comida == carne or comida == carne2:
		get_parent().get_node("Hud/Container").stock_carne -= 1
		var text = str(get_parent().get_node("Hud/Container").stock_carne) + "/10"
		get_parent().get_node("Hud/LibroSuministros/ContainerCarne/StockCarne").set_text(text)
	elif comida == pescado or comida == pescado2:
		get_parent().get_node("Hud/Container").stock_pescado -= 1
		var text = str(get_parent().get_node("Hud/Container").stock_pescado) + "/10"
		get_parent().get_node("Hud/LibroSuministros/ContainerPescado/StockPescado").set_text(text)
	elif comida == verdura or comida == verdura2:
		get_parent().get_node("Hud/Container").stock_verduras -= 1
		var text = str(get_parent().get_node("Hud/Container").stock_verduras) + "/60"
		get_parent().get_node("Hud/LibroSuministros/ContainerVerduras/StockVerduras").set_text(text)
	elif comida == patata or comida == patata2:
		get_parent().get_node("Hud/Container").stock_patatas -= 1
		var text = str(get_parent().get_node("Hud/Container").stock_patatas) + "/80"
		get_parent().get_node("Hud/LibroSuministros/ContainerPatatas/StockPatatas").set_text(text)
	elif comida == pan or comida == pan2:
		get_parent().get_node("Hud/Container").stock_pan -= 1
		var text = str(get_parent().get_node("Hud/Container").stock_pan) + "/20"
		get_parent().get_node("Hud/LibroSuministros/ContainerPan/StockPan").set_text(text)
	elif comida == queso or comida == queso2:
		get_parent().get_node("Hud/Container").stock_queso -= 1
		var text = str(get_parent().get_node("Hud/Container").stock_queso) + "/20"
		get_parent().get_node("Hud/LibroSuministros/ContainerQueso/StockQueso").set_text(text)
	elif comida == huevo or comida == huevo2:
		get_parent().get_node("Hud/Container").stock_huevos -= 1
		var text = str(get_parent().get_node("Hud/Container").stock_huevos) + "/24"
		get_parent().get_node("Hud/LibroSuministros/ContainerHuevos/StockHuevos").set_text(text)

func echarIngrediente(ingrediente):
	personaje.remove_child(ingrediente)
	caldero.add_child(ingrediente)
	ingrediente.hide()

func cocina(receta):
	var texture = caldero.get_texture()
	var mytexture = preload("res://tiles/boil.png")
	for i in range(0, caldero.get_child_count()):
		caldero.get_child(i).queue_free()

	instanciar_ingredientes(carne)
	instanciar_ingredientes(carne2)
	instanciar_ingredientes(pescado)
	instanciar_ingredientes(pescado2)
	instanciar_ingredientes(verdura)
	instanciar_ingredientes(verdura2)
	instanciar_ingredientes(patata)
	instanciar_ingredientes(patata2)
	instanciar_ingredientes(huevo)
	instanciar_ingredientes(huevo2)
	
	cocina = true
	notificaciones("La comida se está cocinando")
	get_parent().get_node("Hud/Cocina").show()
	get_parent().get_node("BarraDetras").remove_child(caldero)
	get_parent().get_node("BarraDetras").add_child(calderoAnimado)
	calderoAnimado.get_node("AnimationPlayer").play("Hervir")
	timer2.set_one_shot(true)
	self.add_child(timer2)
	timer2.start()
	yield(timer2, "timeout")
	if receta == "Carne cocinada":
		for i in range(0,4):
			var carneCocinada = spriteCarneCocinada.instance()
			caldero.add_child(carneCocinada)
			carneCocinada.hide()
	elif receta == "Pescado cocinado":
		for i in range(0,4):
			var pescadoCocinado = spritePescadoCocinado.instance()
			caldero.add_child(pescadoCocinado)
			pescadoCocinado.hide()
	elif receta == "Quebrantos":
		for i in range(2):
			var quebrantos = spriteQuebrantos.instance()
			caldero.add_child(quebrantos)
			quebrantos.hide()
	elif receta == "Sopa":
		for i in range(0,10):
			var sopa = spriteSopa.instance()
			caldero.add_child(sopa)
			sopa.hide()
	elif receta == "Olla":
		for i in range(0,10):
			var olla = spriteOlla.instance()
			caldero.add_child(olla)
			olla.hide()
	elif receta == "Estofado":
		for i in range(0,10):
			var estofado = spriteEstofado.instance()
			caldero.add_child(estofado)
			estofado.hide()
	notificaciones("La comida está lista")
	cocina = false
	contadorCarne = 0
	contadorPescado = 0
	contadorVerduras = 0
	contadorPatatas = 0
	contadorHuevos = 0
	get_parent().get_node("Hud/Cocina").hide()
	get_parent().get_node("Hud/Raciones").show()
	comidaCocinada = true
	calderoAnimado.get_node("AnimationPlayer").stop()
	get_parent().get_node("BarraDetras").remove_child(calderoAnimado)
	instanciar_caldero()
	get_parent().get_node("BarraDetras").add_child(caldero)

func cogerComidaCocinada(comida, mano):
	caldero.get_child(0).free()
	var comidaCocinada
	if comida == "Carne":
		comidaCocinada = spriteCarneCocinada.instance()
	elif comida == "Pescado":
		comidaCocinada = spritePescadoCocinado.instance()
	elif comida == "Quebrantos":
		comidaCocinada = spriteQuebrantos.instance()
	elif comida == "Sopa":
		comidaCocinada = spriteSopa.instance()
	elif comida == "Olla":
		comidaCocinada = spriteOlla.instance()
	elif comida == "Estofado":
		comidaCocinada = spriteEstofado.instance()
	personaje.add_child(comidaCocinada)
	if mano == "Derecha":
		comidaCocinada.set_pos(mano_derecha)
	elif mano == "Izquierda":
		comidaCocinada.set_pos(mano_izquierda)

func instanciar_jarras(recipiente):
	if recipiente == "Jarra":
		jarra = spriteJarra.instance()
		jarra.set_pos(mano_derecha)
	elif recipiente == "Jarra2":
		jarra2 = spriteJarra.instance()
		jarra2.set_pos(mano_izquierda)

func instanciar_ingredientes(ingrediente):
	if ingrediente == carne:
		carne = spriteCarne.instance()
		carne.set_pos(mano_derecha)
	elif ingrediente == carne2:
		carne2 = spriteCarne.instance()
		carne2.set_pos(mano_izquierda)
	elif ingrediente == pescado:
		pescado = spritePescado.instance()
		pescado.set_pos(mano_derecha)
	elif ingrediente == pescado2:
		pescado2 = spritePescado.instance()
		pescado2.set_pos(mano_izquierda)
	elif ingrediente == verdura:
		verdura = spriteVerduras.instance()
		verdura.set_pos(mano_derecha)
	elif ingrediente == verdura2:
		verdura2 = spriteVerduras.instance()
		verdura2.set_pos(mano_izquierda)
	elif ingrediente == patata:
		patata = spritePatatas.instance()
		patata.set_pos(mano_derecha)
	elif ingrediente == patata2:
		patata2 = spritePatatas.instance()
		patata2.set_pos(mano_izquierda)
	elif ingrediente == huevo:
		huevo = spriteHuevos.instance()
		huevo.set_pos(mano_derecha)
	elif ingrediente == huevo2:
		huevo2 = spriteHuevos.instance()
		huevo2.set_pos(mano_izquierda)
	elif ingrediente == pan:
		pan = spritePan.instance()
		pan.set_pos(mano_derecha)
	elif ingrediente == pan2:
		pan2 = spritePan.instance()
		pan2.set_pos(mano_izquierda)
	elif ingrediente == queso:
		queso = spriteQueso.instance()
		queso.set_pos(mano_derecha)
	elif ingrediente == queso2:
		queso2 = spriteQueso.instance()
		queso2.set_pos(mano_izquierda)
	elif ingrediente == carne3:
		carne3 = spriteCarne.instance()
		carne3.set_pos(Vector2(290, 42))
		get_parent().get_node("BarraDetras/Alimentos/Carne").add_child(carne3)
	elif ingrediente == pescado3:
		pescado3 = spritePescado.instance()
		pescado3.set_pos(Vector2(640, 42))
		get_parent().get_node("BarraDetras/Alimentos/Pescado").add_child(pescado3)
	elif ingrediente == verdura3:
		verdura3 = spriteVerduras.instance()
		verdura3.set_pos(Vector2(704, 42))
		get_parent().get_node("BarraDetras/Alimentos/Verduras").add_child(verdura3)
	elif ingrediente == patata3:
		patata3 = spritePatatas.instance()
		patata3.set_pos(Vector2(736, 42))
		get_parent().get_node("BarraDetras/Alimentos/Patatas").add_child(patata3)
	elif ingrediente == pan3:
		pan3 = spritePan.instance()
		pan3.set_pos(Vector2(512, 26))
		get_parent().get_node("BarraDetras/Alimentos/Pan").add_child(pan3)
	elif ingrediente == queso3:
		queso3 = spriteQueso.instance()
		queso3.set_pos(Vector2(672, 42))
		get_parent().get_node("BarraDetras/Alimentos/Queso").add_child(queso3)
	elif ingrediente == huevo3:
		huevo3 = spriteHuevos.instance()
		huevo3.set_pos(Vector2(544, 26))
		get_parent().get_node("BarraDetras/Alimentos/Huevos").add_child(huevo3)
	
func dejarComida(comida, hijo):
	if hijo == "0":
		personaje.get_child(0).free()
	elif hijo == "1":
		personaje.get_child(1).free()
	var comidaCocinada
	
	if comida == "Carne":
		get_parent().get_node("Hud/Container").stock_carne += 1
		var text = str(get_parent().get_node("Hud/Container").stock_carne) + "/10"
		get_parent().get_node("Hud/LibroSuministros/ContainerCarne/StockCarne").set_text(text)
	elif comida == "Pescado":
		get_parent().get_node("Hud/Container").stock_pescado += 1
		var text = str(get_parent().get_node("Hud/Container").stock_pescado) + "/10"
		get_parent().get_node("Hud/LibroSuministros/ContainerPescado/StockPescado").set_text(text)
	elif comida == "Verdura":
		get_parent().get_node("Hud/Container").stock_verduras += 1
		var text = str(get_parent().get_node("Hud/Container").stock_verduras) + "/60"
		get_parent().get_node("Hud/LibroSuministros/ContainerVerduras/StockVerduras").set_text(text)
	elif comida == "Patata":
		get_parent().get_node("Hud/Container").stock_patatas += 1
		var text = str(get_parent().get_node("Hud/Container").stock_patatas) + "/80"
		get_parent().get_node("Hud/LibroSuministros/ContainerPatatas/StockPatatas").set_text(text)
	elif comida == "Pan":
		get_parent().get_node("Hud/Container").stock_pan += 1
		var text = str(get_parent().get_node("Hud/Container").stock_pan) + "/20"
		get_parent().get_node("Hud/LibroSuministros/ContainerPan/StockPan").set_text(text)
	elif comida == "Queso":
		get_parent().get_node("Hud/Container").stock_queso += 1
		var text = str(get_parent().get_node("Hud/Container").stock_queso) + "/20"
		get_parent().get_node("Hud/LibroSuministros/ContainerQueso/StockQueso").set_text(text)
	elif comida == "Huevo":
		get_parent().get_node("Hud/Container").stock_huevos += 1
		var text = str(get_parent().get_node("Hud/Container").stock_huevos) + "/24"
		get_parent().get_node("Hud/LibroSuministros/ContainerHuevos/StockHuevos").set_text(text)
	elif comida == "Carne cocinada":
		comidaCocinada = spriteCarneCocinada.instance()
		caldero.add_child(comidaCocinada)
	elif comida == "Pescado cocinado":
		comidaCocinada = spritePescadoCocinado.instance()
		caldero.add_child(comidaCocinada)
	elif comida == "Quebrantos":
		comidaCocinada = spriteQuebrantos.instance()
		caldero.add_child(comidaCocinada)
	elif comida == "Sopa":
		comidaCocinada = spriteSopa.instance()
		caldero.add_child(comidaCocinada)
	elif comida == "Olla":
		comidaCocinada = spriteOlla.instance()
		caldero.add_child(comidaCocinada)
	elif comida == "Estofado":
		comidaCocinada = spriteEstofado.instance()
		caldero.add_child(comidaCocinada)

func instanciar_caldero():
	calderoAnimado = spriteCaldero.instance()
	calderoAnimado.set_pos(pos_caldero)