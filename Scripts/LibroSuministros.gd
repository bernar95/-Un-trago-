extends Patch9Frame
#Este script se utiliza para lo relacionado con el libro de sumiistros, que 
#básicamente se limita a abrirlo y cerrarlo  
var suministros
var mapa
var mostrarSuministros = false
var tiempo = Timer.new()

func _ready():
	hide()
	
	suministros = get_parent().get_node("Suministros")
	var cerrar = get_node("CerrarSuministros")
	mapa = get_parent().get_parent()
	tiempo.set_one_shot(true)
	self.add_child(tiempo)
	
	if suministros:
		suministros.connect("pressed", self, "_mostrar_suministros")
	if cerrar:
		cerrar.connect("pressed", self, "_cerrar_suministros")
	pass

func _mostrar_suministros():
	get_parent().get_parent().get_node("Sonidos/SamplePlayer2D").play("Abrir_libro", 10)
	tiempo.set_wait_time(0.5)
	tiempo.start()
	yield(tiempo, "timeout")
	mostrarSuministros = true
	show()
	get_parent().get_node("Dia").set_text("")
	mapa.cerrar_Botones()
	pass

func _cerrar_suministros():
	get_parent().get_parent().get_node("Sonidos/SamplePlayer2D").play("Cerrar_libro", 10)
	tiempo.set_wait_time(0.25)
	tiempo.start()
	yield(tiempo, "timeout")
	mostrarSuministros = false
	hide()
	mapa.mostrar_botones()
	pass