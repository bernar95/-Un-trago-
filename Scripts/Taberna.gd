extends Node
#Este script sirve para la gestión del tiempo y el spawn de npcs
var diasAbierto = 1

var tiempo = Timer.new()

var labelDia
var labelMomento
var labelTiempo
var aparecer = false
var servir_comida = false
var compras
var recetas
var pedidos
var suministros
var preciosBoton
var spawn

func _ready():
	compras = get_node("Hud/Compras")
	recetas = get_node("Hud/Recetas")
	pedidos = get_node("Hud/Pedidos")
	suministros = get_node("Hud/Suministros")
	preciosBoton = get_node("Hud/Precios")
	tiempo.set_one_shot(true)
	self.add_child(tiempo)
	set_fixed_process(true)
	set_process_input(true)
	labelDia = get_node("Hud/Dia")
	labelMomento = get_node("Hud/MomentoDia")
	labelTiempo = get_node("Hud/Tiempo")
	get_node("Hud/Menu_pausa").hide()
	spawn = get_node("Navegacion")
	tiempo()
	pass
#Esta función es propia de godot, y sirve para comprobar cuando se inserta
#un determinado evento. En este caso comprueba cuando se pulsa una tecla, la 
#cual, de ser pulsada, pausa el juego y provoca la aparición del menú de pausa
func _input(event):
	if event.type == InputEvent.KEY:
		if event.is_action_pressed("ui_pause"):
			get_tree().set_pause(true)
			get_node("Hud/Menu_pausa").show()

func _fixed_process(delta):
	labelTiempo.set_text(str(int(tiempo.get_time_left())))
	 
	if aparecer == true:
		labelTiempo.show()
	else:
		labelTiempo.hide()
	
#Esta función sirve para la gestión del tiempo de la taberna. Al iniciar una 
#nueva partida, se llama a esta función y comienza mostrando el día actual
#(el día 1 en este caso), después muestra un tiempo que el jugador dispone
#para organizarse(hacer pedidos, preparar comidas...), y luego muestra el 
#tiempo de la mañana, después el de la tarde y por último el de la noche, 
#durante los mismos van a ir apareciendo los diversos npcs. Cuando se acaba
#el día se suma una unidad a la variable "diasAbierto" y se vuelve a empezar,
#siendo esta vez un día distinto, y así sucesivamente
func tiempo():
	labelDia.set_text("Día" + " " + str(diasAbierto))
	labelDia.show()
	tiempo.set_wait_time(8)
	tiempo.start()
	yield(tiempo, "timeout")
	labelDia.hide()
	
	if servir_comida == true:
		get_node("Hud/PlatoDia").show()
	
	labelMomento.set_text("Organización")
	aparecer = true
	tiempo.set_wait_time(30)
	tiempo.start()
	yield(tiempo, "timeout")
	get_node("Hud/PlatoDia").hide()
	
	labelMomento.set_text("Mañana")
	global.labelMomento = labelMomento.get_text()
	tiempo.set_wait_time(180)
	spawn.numero_npcs()
	spawn.establecer_espera()
	tiempo.start()
	spawn.aparecer_npcs()
	yield(tiempo, "timeout")
	
	labelMomento.set_text("Tarde")
	global.labelMomento = labelMomento.get_text()
	tiempo.set_wait_time(180)
	spawn.numero_npcs()
	spawn.establecer_espera()
	tiempo.start()
	spawn.aparecer_npcs()
	yield(tiempo, "timeout")
	
	labelMomento.set_text("Noche")
	global.labelMomento = labelMomento.get_text()
	tiempo.set_wait_time(180)
	spawn.numero_npcs()
	spawn.establecer_espera()
	tiempo.start()
	spawn.aparecer_npcs()
	yield(tiempo, "timeout")
	
	diasAbierto += 1
	get_node("Hud/Dia").set_text("")
	labelMomento.set_text("")
	aparecer = false
	tiempo()

func mostrar_botones():
	compras.show()
	pedidos.show()
	recetas.show()
	suministros.show()
	preciosBoton.show()

func cerrar_Botones():
	compras.hide()
	pedidos.hide()
	recetas.hide()
	suministros.hide()
	preciosBoton.hide()

func save():
	var save_dict = {
		dias_abierto=diasAbierto,
		_servir_comida=servir_comida
	}
	return save_dict