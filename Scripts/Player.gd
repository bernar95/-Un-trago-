extends KinematicBody2D

var direction = Vector2(0,0)
var startPos = Vector2(0,0)
var moving = false

var personaje
var animationPlayer

var mapa

var speed = 1
const GRID = 16

func _ready():
	mapa = get_world_2d().get_direct_space_state()
	set_fixed_process(true)
	personaje = get_node("Personaje")
	animationPlayer = get_node("AnimationPlayer")
	
func _fixed_process(delta):
	if !moving:
		var arriba = mapa.intersect_point(get_pos() + Vector2(0, -GRID))
		var abajo = mapa.intersect_point(get_pos() + Vector2(0, GRID))
		var izquierda = mapa.intersect_point(get_pos() + Vector2(-GRID, 0))
		var derecha = mapa.intersect_point(get_pos() + Vector2(GRID, 0))
		
		if Input.is_key_pressed(KEY_W):
			personaje.set_frame(12)
			if arriba.empty():
				moving = true
				direction = Vector2(0, -1)
				startPos = get_pos()
				animationPlayer.play("Andar arriba")
				if Input.is_key_pressed(KEY_SHIFT):
					speed = 2
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
					speed = 2
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
					speed = 2
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
					speed = 2
					animationPlayer.play("Andar derecha rapido")
				elif Input.is_key_pressed(KEY_SHIFT) == false:
					speed = 1

	else:
		move_to(get_pos() + direction * speed)
		if get_pos() == startPos + Vector2(direction.x * GRID, direction.y * GRID):
			moving = false
