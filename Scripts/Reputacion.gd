extends Node2D
#Este script se utiliza para todo lo relacionado con la reputación
#de la taberna
var barraProgresion
var pos = Vector2(-16, 18)
var reputacion = 0
var bronce = preload("res://Scenes/bronce.tscn")
var plata = preload("res://Scenes/plata.tscn")
var oro = preload("res://Scenes/oro.tscn")
var platino = preload("res://Scenes/platino.tscn")
var experienciaActual = 0
var experienciaObjetivo = 3
var cerveceria = false
var aperitivos = false
var comida = false
var medallaBronce = false
var medallaPlata = false
var medallaOro = false
var medallaPlatino = false

var insBronce = bronce.instance()
var insPlata = plata.instance()
var insOro = oro.instance()
var insPlatino = platino.instance()

func _ready():
	barraProgresion = get_node("Experiencia")
	set_fixed_process(true)
	insBronce.set_pos(pos)
	insPlata.set_pos(pos)
	insOro.set_pos(pos)
	insPlatino.set_pos(pos)
	pass
#Esta función, que es propia de godot, va comprobado en cada frame del juego
#todas las condiciones que se le pasan. En mi caso,se utiliza para notificaciones
#de permisos disponibles y de medallas ganadas
func _fixed_process(delta):
	if reputacion == 5 and cerveceria == false:
		get_parent().get_node("LibroCompras/PermisoCerveceria").show()
		get_parent().get_parent().get_node("KinematicBody2D").notificaciones("El permiso de cervecería está disponible")
		cerveceria = true
	elif reputacion == 10 and aperitivos == false:
		get_parent().get_node("LibroCompras/PermisoAperitivos").show()
		get_parent().get_parent().get_node("KinematicBody2D").notificaciones("El permiso de aperitivos está disponible")
		aperitivos = true
	elif reputacion == 15 and comida == false:
		get_parent().get_node("LibroCompras/PermisoComidas").show()
		get_parent().get_parent().get_node("KinematicBody2D").notificaciones("El permiso de comidas está disponible")
		comida = true
	elif reputacion == 25 and medallaBronce == false:
		get_node("Reputacion").add_child(insBronce)
		get_parent().get_parent().get_node("KinematicBody2D").notificaciones("Has ganado la medalla de bronce")
		medallaBronce = true
	elif reputacion == 50 and medallaPlata == false:
		get_node("Reputacion").remove_child(insBronce)
		get_node("Reputacion").add_child(insPlata)
		get_parent().get_parent().get_node("KinematicBody2D").notificaciones("Has ganado la medalla de plata")
		medallaPlata = true
	elif reputacion == 75 and medallaOro == false:
		get_node("Reputacion").remove_child(insPlata)
		get_node("Reputacion").add_child(insOro)
		get_parent().get_parent().get_node("KinematicBody2D").notificaciones("Has ganado la medalla de oro")
		medallaOro = true
	elif reputacion == 100 and medallaPlatino == false:
		get_node("Reputacion").remove_child(insOro)
		get_node("Reputacion").add_child(insPlatino)
		get_parent().get_parent().get_node("KinematicBody2D").notificaciones("Has ganado la medalla de platino")
		medallaPlatino = true
#Esta función se utiliza para añadir experiencia a la barra de progresión,
#que se irá rellenando hasta alcanzar el objetivo del nivel actual. Una
#vez conseguido el objetivo, se resetean la experiencia y la barra de progresión,
#y se le añaden una unidad más al nivel de reputación y al objetivo
func masExperiencia():
	experienciaActual += 1
	var progresion = (experienciaActual*100)/experienciaObjetivo
	barraProgresion.set_value(progresion)
	if experienciaActual == experienciaObjetivo:
		experienciaActual = 0
		barraProgresion.set_value(0)
		experienciaObjetivo += 1
		reputacion += 1
		get_node("Reputacion").set_text(str(reputacion))
#Está función es igual a la anterior, pero restando experiencia
func menosExperiencia():
	var progresion 
	experienciaActual -= 1
	if experienciaActual < 0:
		experienciaActual += experienciaObjetivo - 1
		experienciaObjetivo -= 1
		reputacion -= 1
		get_node("Reputacion").set_text(str(reputacion))
	progresion = (experienciaActual*100)/experienciaObjetivo
	barraProgresion.set_value(progresion)