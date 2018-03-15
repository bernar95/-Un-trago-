extends Sprite

var speed = 100
const eps = 1.5
var points = [] 
var navegacion = null setget set_navegacion
var destino = Vector2()
var andar = true
var animationPlayer
var rigidBody

func _ready():
	set_fixed_process(true)
	set_frame(12)
	rigidBody = get_parent()
	animationPlayer = get_parent().get_node("AnimationPlayer")
	pass

func _fixed_process(delta):
	if andar == true:
		moverNpc()
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
	else:
		animationPlayer.stop()

func set_navegacion(navegacion_nueva):
	navegacion = navegacion_nueva

func moverNpc():
	points = navegacion.get_simple_path(rigidBody.get_global_pos(), destino, true)
	if points.size() > 1:
		var distance = points[1] -  rigidBody.get_global_pos() 
		var direction = distance.normalized()
		if distance.length() > eps or points.size() > 2:
			rigidBody.set_linear_velocity(direction*speed)
		else:
			rigidBody.set_linear_velocity(Vector2(0, 0))
			andar = false
		rigidBody.update()
