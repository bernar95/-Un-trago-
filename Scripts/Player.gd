extends KinematicBody2D

var direction = Vector2(0,0)
var startPos = Vector2(0,0)
var moving = false
var mano_derecha = Vector2(8.841199, 5.105545)
var mano_izquierda= Vector2(-8.841199, 5.105545)
var timer = Timer.new()

var spriteCerveza = preload("res://Scenes/JarraCerveza.tscn")
var cerveza = spriteCerveza.instance()
var cerveza2 = spriteCerveza.instance()
var spriteVino = preload("res://Scenes/JarraVino.tscn")
var vino = spriteVino.instance()
var vino2 = spriteVino.instance()

var personaje
var animationPlayer
var notificaciones 
var mapa

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
	
func _fixed_process(delta):
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
	

func interaccion(result):
	var spriteJarra = preload("res://Scenes/Jarra.tscn")
	var jarra = spriteJarra.instance()
	var jarra2 = spriteJarra.instance()
	jarra.set_pos(mano_derecha)
	jarra2.set_pos(mano_izquierda)
	cerveza.set_pos(mano_derecha)
	cerveza2.set_pos(mano_izquierda)
	vino.set_pos(mano_derecha)
	vino2.set_pos(mano_izquierda)

	if typeof(result[0].collider) == TYPE_OBJECT:
		if result[0].collider.has_node("EstanteInteraccion"):
			if personaje.get_child_count() == 0:
				personaje.add_child(jarra)
			elif personaje.get_child_count() == 1:
				personaje.add_child(jarra2)
			else:
				notificaciones("Tienes las manos ocupadas")
		elif result[0].collider.has_node("BarrilCervezaInteraccion") or result[0].collider.has_node("BarrilVinoInteraccion"):
			if personaje.get_child_count() == 0:
				notificaciones("Necesitas una jarra vacía")
			elif personaje.get_child_count() == 1:
				if personaje.get_child(0).get_filename() == spriteCerveza.get_path() or personaje.get_child(0).get_filename() == spriteVino.get_path():
					notificaciones("La jarra ya está llena")
				else:
					if get_parent().get_node("Hud/Container").stock_cerveza == 0 and result[0].collider.has_node("BarrilCervezaInteraccion"):
						notificaciones("No tienes cerveza")
					elif get_parent().get_node("Hud/Container").stock_vino == 0 and result[0].collider.has_node("BarrilVinoInteraccion"):
						notificaciones("No tienes vino")
					elif get_parent().get_node("Hud/Container").stock_cerveza > 0 and result[0].collider.has_node("BarrilCervezaInteraccion"):
						rellenarJarra(cerveza)
					elif get_parent().get_node("Hud/Container").stock_vino > 0 and result[0].collider.has_node("BarrilVinoInteraccion"):
						rellenarJarra(vino)
			elif personaje.get_child_count() == 2:
				if personaje.get_child(0).get_filename() == spriteJarra.get_path() and personaje.get_child(1).get_filename() == spriteJarra.get_path():
					if get_parent().get_node("Hud/Container").stock_cerveza == 0 and result[0].collider.has_node("BarrilCervezaInteraccion"):
						notificaciones("No tienes cerveza")
					elif get_parent().get_node("Hud/Container").stock_vino == 0 and result[0].collider.has_node("BarrilVinoInteraccion"):
						notificaciones("No tienes vino")
					elif get_parent().get_node("Hud/Container").stock_cerveza == 1 and result[0].collider.has_node("BarrilCervezaInteraccion"):
						rellenarJarra(cerveza)
						notificaciones("No tienes cerveza para ambas jarras")
					elif get_parent().get_node("Hud/Container").stock_vino == 1 and result[0].collider.has_node("BarrilVinoInteraccion"):
						rellenarJarra(vino)
						notificaciones("No tienes vino para ambas jarras")
					elif get_parent().get_node("Hud/Container").stock_cerveza >= 2 and result[0].collider.has_node("BarrilCervezaInteraccion"):
						rellenarDosJarras(cerveza, cerveza2)
					elif get_parent().get_node("Hud/Container").stock_vino >= 2 and result[0].collider.has_node("BarrilVinoInteraccion"):
						rellenarDosJarras(vino, vino2)
				elif personaje.get_child(0).get_filename() == spriteCerveza.get_path() and personaje.get_child(1).get_filename() == spriteCerveza.get_path() or personaje.get_child(0).get_filename() == spriteVino.get_path() and personaje.get_child(1).get_filename() == spriteVino.get_path() or personaje.get_child(0).get_filename() == spriteVino.get_path() and personaje.get_child(1).get_filename() == spriteCerveza.get_path() or personaje.get_child(0).get_filename() == spriteCerveza.get_path() and personaje.get_child(1).get_filename() == spriteVino.get_path():
					notificaciones("Tienes las jarras llenas")
				else:
					if get_parent().get_node("Hud/Container").stock_cerveza > 0 and result[0].collider.has_node("BarrilCervezaInteraccion"):
						if personaje.get_child(1).get_filename() == spriteJarra.get_path():
							personaje.get_child(1).free()
						else:
							personaje.get_child(0).free()
							
						personaje.add_child(cerveza2)
						get_parent().get_node("Hud/Container").stock_cerveza -= 1
						var text = str(get_parent().get_node("Hud/Container").stock_cerveza) + "/90"
						get_parent().get_node("Hud/LibroSuministros/ContainerCerveza/StockCerveza").set_text(text)
						
					elif get_parent().get_node("Hud/Container").stock_vino > 0 and result[0].collider.has_node("BarrilVinoInteraccion"):
						if personaje.get_child(1).get_filename() == spriteJarra.get_path():
							personaje.get_child(1).free()
						else:
							personaje.get_child(0).free()
							
						personaje.add_child(vino2)
						get_parent().get_node("Hud/Container").stock_vino -= 1
						var text = str(get_parent().get_node("Hud/Container").stock_vino) + "/90"
						get_parent().get_node("Hud/LibroSuministros/ContainerVino/StockVino").set_text(text)
					elif get_parent().get_node("Hud/Container").stock_cerveza == 0 and result[0].collider.has_node("BarrilCervezaInteraccion"):
						notificaciones("No tienes cerveza")
					elif get_parent().get_node("Hud/Container").stock_vino == 0 and result[0].collider.has_node("BarrilVinoInteraccion"):
						notificaciones("No tienes vino")

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

func rellenarJarra(bebida):
	cerveza.set_pos(mano_derecha)
	vino.set_pos(mano_derecha)
	
	personaje.get_child(0).free()
	personaje.add_child(bebida)
	if bebida == cerveza:
		get_parent().get_node("Hud/Container").stock_cerveza -= 1
		var text = str(get_parent().get_node("Hud/Container").stock_cerveza) + "/90"
		get_parent().get_node("Hud/LibroSuministros/ContainerCerveza/StockCerveza").set_text(text)
	else:
		get_parent().get_node("Hud/Container").stock_vino -= 1
		var text = str(get_parent().get_node("Hud/Container").stock_vino) + "/90"
		get_parent().get_node("Hud/LibroSuministros/ContainerVino/StockVino").set_text(text)

func rellenarDosJarras(bebida1, bebida2):
	cerveza.set_pos(mano_derecha)
	cerveza2.set_pos(mano_izquierda)
	vino.set_pos(mano_derecha)
	vino2.set_pos(mano_izquierda)
	
	for child in personaje.get_children():
		personaje.remove_child(child)
	personaje.add_child(bebida1)
	personaje.add_child(bebida2)
	if bebida1 == cerveza and bebida2 == cerveza2:
		get_parent().get_node("Hud/Container").stock_cerveza -= 2
		var text = str(get_parent().get_node("Hud/Container").stock_cerveza) + "/90"
		get_parent().get_node("Hud/LibroSuministros/ContainerCerveza/StockCerveza").set_text(text)
	else:
		get_parent().get_node("Hud/Container").stock_vino -= 2
		var text = str(get_parent().get_node("Hud/Container").stock_vino) + "/90"
		get_parent().get_node("Hud/LibroSuministros/ContainerVino/StockVino").set_text(text)
	
	
	