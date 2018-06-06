extends Patch9Frame
#Este script se utiliza para lo relacionado con el libro de precios, que 
#básicamente se limita a abrirlo, cerrarlo y ocultar su contenido,
#ya que se irá desbloqueando conforme el jugador avance 
var precios
var mostrarPrecios = false
var mapa
var tiempo = Timer.new()

func _ready():
	hide()
	
	precios = get_parent().get_node("Precios")
	var cerrar = get_node("CerrarPrecios")
	mapa = get_parent().get_parent()
	tiempo.set_one_shot(true)
	self.add_child(tiempo)
	
	get_node("Cerveza").hide()
	get_node("Pan").hide()
	get_node("Queso").hide()
	get_node("Carne").hide()
	get_node("Pescado").hide()
	get_node("Sopa").hide()
	get_node("Quebrantos").hide()
	get_node("Olla").hide()
	get_node("Estofado").hide()
	
	if precios:
		precios.connect("pressed", self, "_mostrar_precios")
	if cerrar:
		cerrar.connect("pressed", self, "_cerrar_precios")
	pass

func _mostrar_precios():
	get_parent().get_parent().get_node("Sonidos/SamplePlayer2D").play("Abrir_libro", 10)
	tiempo.set_wait_time(0.5)
	tiempo.start()
	yield(tiempo, "timeout")
	mostrarPrecios = true
	show()
	get_parent().get_node("Dia").set_text("")
	mapa.cerrar_Botones()
	pass

func _cerrar_precios():
	get_parent().get_parent().get_node("Sonidos/SamplePlayer2D").play("Cerrar_libro", 10)
	tiempo.set_wait_time(0.25)
	tiempo.start()
	yield(tiempo, "timeout")
	mostrarPrecios = false
	hide()
	mapa.mostrar_botones()
	pass