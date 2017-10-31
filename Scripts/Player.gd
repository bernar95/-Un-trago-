extends KinematicBody2D

var direction = Vector2(0,0)
var startPos = Vector2(0,0)
var moving = false

const SPEED = 3

func _ready():
	set_fixed_process(true)
	
func _fixed_process(delta):
	if !moving:
		if Input.is_action_pressed("ui_up"):
			moving = true
			direction = Vector2(0, -1)
			startPos = get_pos()
		elif Input.is_action_pressed("ui_down"):
			moving = true
			direction = Vector2(0, 1)
			startPos = get_pos()
		elif Input.is_action_pressed("ui_left"):
			moving = true
			direction = Vector2(-1, 0)
			startPos = get_pos()
		elif Input.is_action_pressed("ui_right"):
			moving = true
			direction = Vector2(1, 0)
			startPos = get_pos()
	else:
		move_to(get_pos() + direction * SPEED)
		if get_pos() == startPos + Vector2(direction.x * SPEED, direction.y * SPEED):
			moving = false
