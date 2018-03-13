extends Node

var diasAbierto = 1

var tiempo = Timer.new()

var labelDia
var labelMomento
var labelTiempo
var aparecer = false

func _ready():
	tiempo.set_one_shot(true)
	self.add_child(tiempo)
	set_fixed_process(true)
	labelDia = get_node("Hud/Dia")
	labelMomento = get_node("Hud/MomentoDia")
	labelTiempo = get_node("Hud/Tiempo")
	tiempo()
	pass

func _fixed_process(delta):
	labelTiempo.set_text(str(int(tiempo.get_time_left())))
	 
	if aparecer == true:
		labelTiempo.show()
	else:
		labelTiempo.hide()
	

func tiempo():
	labelDia.set_text("Día" + " " + str(diasAbierto))
	labelDia.show()
	tiempo.set_wait_time(5)
	tiempo.start()
	yield(tiempo, "timeout")
	labelDia.hide()
	
	labelMomento.set_text("Hora de hacer pedidos")
	aparecer = true
	tiempo.set_wait_time(10)
	tiempo.start()
	yield(tiempo, "timeout")
	
	labelMomento.set_text("Mañana")
	tiempo.set_wait_time(10)
	tiempo.start()
	yield(tiempo, "timeout")
	
	labelMomento.set_text("Tarde")
	tiempo.set_wait_time(10)
	tiempo.start()
	yield(tiempo, "timeout")
	
	labelMomento.set_text("Noche")
	tiempo.set_wait_time(10)
	tiempo.start()
	yield(tiempo, "timeout")
	
	diasAbierto += 1
	get_node("Hud/Dia").set_text("")
	labelMomento.set_text("")
	aparecer = false
	tiempo()