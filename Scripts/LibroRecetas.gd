extends Patch9Frame
#Este script se utiliza para lo relacionado con el libro de recetas, que 
#básicamente se limita a abrirlo, cerrarlo y ocultar su contenido,
#ya que se irá desbloqueando conforme el jugador avance 
var recetas
var mapa
var mostrarRecetas = false
var tiempo = Timer.new()

func _ready():
	hide()
	
	get_node("Chuletas").hide()
	get_node("Bacalao").hide()
	get_node("Quebrantos").hide()
	get_node("Sopa").hide()
	get_node("Olla").hide()
	get_node("Estofado").hide()
	tiempo.set_one_shot(true)
	self.add_child(tiempo)
	
	recetas = get_parent().get_node("Recetas")
	var cerrar = get_node("CerrarRecetas")
	mapa = get_parent().get_parent()
	
	if recetas:
		recetas.connect("pressed", self, "_mostrar_recetas")
	if cerrar:
		cerrar.connect("pressed", self, "_cerrar_recetas")
	pass

func _mostrar_recetas():
	get_parent().get_parent().get_node("Sonidos/SamplePlayer2D").play("Abrir_libro", 10)
	tiempo.set_wait_time(0.5)
	tiempo.start()
	yield(tiempo, "timeout")
	mostrarRecetas = true
	show()
	get_parent().get_node("Dia").set_text("")
	mapa.cerrar_Botones()
	pass

func _cerrar_recetas():
	get_parent().get_parent().get_node("Sonidos/SamplePlayer2D").play("Cerrar_libro", 10)
	tiempo.set_wait_time(0.25)
	tiempo.start()
	yield(tiempo, "timeout")
	mostrarRecetas = false
	hide()
	mapa.mostrar_botones()
	pass