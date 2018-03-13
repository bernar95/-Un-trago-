extends Patch9Frame

var dinero
var compras
var recetas
var pedidos
var suministros
var precios
var compradoCerveza
var compradoAperitivos
var compradoComida
var compradoQuebrantos
var compradoSopa
var compradoOlla
var compradoEstofado
var insuficiente
var comprarCerveza
var comprarAperitivos
var comprarComida
var comprarQuebrantos
var comprarSopa
var comprarOlla
var comprarEstofado
var mostrarCompras = false

func _ready():
	hide()
	
	dinero = int(get_parent().get_node("Dinero").get_text())
	compradoCerveza = get_node("PermisoCerveceria/Comprado")
	compradoAperitivos = get_node("PermisoAperitivos/Comprado")
	compradoComida = get_node("PermisoComidas/Comprado")
	compradoQuebrantos = get_node("RecetaQuebrantos/Comprado")
	compradoSopa = get_node("RecetaSopa/Comprado")
	compradoOlla = get_node("RecetaOlla/Comprado")
	compradoEstofado = get_node("RecetaEstofado/Comprado")
	insuficiente = get_node("DineroInsuficiente")
	
	insuficiente.hide()
	compradoCerveza.hide()
	compradoAperitivos.hide()
	compradoComida.hide()
	compradoQuebrantos.hide()
	compradoSopa.hide()
	compradoOlla.hide()
	compradoEstofado.hide()
	
	get_node("PermisoCerveceria").hide()
	get_node("PermisoAperitivos").hide()
	get_node("PermisoComidas").hide()
	get_node("RecetaQuebrantos").hide()
	get_node("RecetaSopa").hide()
	get_node("RecetaOlla").hide()
	get_node("RecetaEstofado").hide()
	
	compras = get_parent().get_node("Compras")
	recetas = get_parent().get_node("Recetas")
	var cerrar = get_node("CerrarCompras")
	pedidos = get_parent().get_node("Pedidos")
	suministros = get_parent().get_node("Suministros")
	precios = get_parent().get_node("Precios")
	
	comprarCerveza = get_node("PermisoCerveceria/Comprar")
	comprarAperitivos = get_node("PermisoAperitivos/Comprar")
	comprarComida = get_node("PermisoComidas/Comprar")
	comprarQuebrantos = get_node("RecetaQuebrantos/Comprar")
	comprarSopa = get_node("RecetaSopa/Comprar")
	comprarOlla = get_node("RecetaOlla/Comprar")
	comprarEstofado = get_node("RecetaEstofado/Comprar")
	
	if compras:
		compras.connect("pressed", self, "_mostrar_compras")
	if cerrar:
		cerrar.connect("pressed", self, "_cerrar_compras")
	if comprarCerveza:
		comprarCerveza.connect("pressed", self, "_comprar_cerveza")
	if comprarAperitivos:
		comprarAperitivos.connect("pressed", self, "_comprar_aperitivos")
	if comprarComida:
		comprarComida.connect("pressed", self, "_comprar_comida")
	if comprarQuebrantos:
		comprarQuebrantos.connect("pressed", self, "_comprar_quebrantos")
	if comprarSopa:
		comprarSopa.connect("pressed", self, "_comprar_sopa")
	if comprarOlla:
		comprarOlla.connect("pressed", self, "_comprar_olla")
	if comprarEstofado:
		comprarEstofado.connect("pressed", self, "_comprar_estofado")
	pass

func _mostrar_compras():
	mostrarCompras = true
	show()
	get_parent().get_node("Dia").set_text("")
	compras.hide()
	recetas.hide()
	pedidos.hide()
	suministros.hide()
	precios.hide()
	pass

func _cerrar_compras():
	mostrarCompras = false
	hide()
	compras.show()
	recetas.show()
	pedidos.show()
	suministros.show()
	precios.show()
	pass

func temporizador():
	insuficiente.show()
	var t = Timer.new()
	t.set_wait_time(5)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	yield(t, "timeout")
	insuficiente.hide()

func _comprar_cerveza():
	var precio = int(get_node("PermisoCerveceria/Precio").get_text())
	
	if precio <= dinero:
		dinero -= precio
		get_parent().get_node("Dinero").set_text(str(dinero))
		compradoCerveza.show()
		comprarCerveza.hide()
		get_parent().get_node("Container/LibroPedidos/Cerveza").show()
		get_parent().get_node("LibroPrecios/Cerveza").show()
	else:
		temporizador()
	

func _comprar_aperitivos():
	var precio = int(get_node("PermisoAperitivos/Precio").get_text())
	
	if precio <= dinero:
		dinero -= precio
		get_parent().get_node("Dinero").set_text(str(dinero))
		compradoAperitivos.show()
		comprarAperitivos.hide()
		get_parent().get_node("Container/LibroPedidos/Pan").show()
		get_parent().get_node("Container/LibroPedidos/Queso").show()
		get_parent().get_node("LibroPrecios/Pan").show()
		get_parent().get_node("LibroPrecios/Queso").show()
	else:
		temporizador()

func _comprar_comida():
	var precio = int(get_node("PermisoComidas/Precio").get_text())
	
	if precio <= dinero:
		dinero -= precio
		get_parent().get_node("Dinero").set_text(str(dinero))
		compradoComida.show()
		comprarComida.hide()
		get_parent().get_node("Container/LibroPedidos/Carne").show()
		get_parent().get_node("Container/LibroPedidos/Pescado").show()
		get_parent().get_node("Container/LibroPedidos/Verduras").show()
		get_parent().get_node("Container/LibroPedidos/Patatas").show()
		get_parent().get_node("Container/LibroPedidos/Huevos").show()
		get_parent().get_node("LibroRecetas/Chuletas").show()
		get_parent().get_node("LibroRecetas/Bacalao").show()
		get_node("RecetaQuebrantos").show()
		get_node("RecetaSopa").show()
		get_node("RecetaOlla").show()
		get_node("RecetaEstofado").show()
		get_parent().get_node("LibroPrecios/Carne").show()
		get_parent().get_node("LibroPrecios/Pescado").show()
	else:
		temporizador()

func _comprar_sopa():
	var precio = int(get_node("RecetaSopa/Precio").get_text())
	
	if precio <= dinero:
		dinero -= precio
		get_parent().get_node("Dinero").set_text(str(dinero))
		compradoSopa.show()
		comprarSopa.hide()
		get_parent().get_node("LibroRecetas/Sopa").show()
		get_parent().get_node("LibroPrecios/Sopa").show()
	else:
		temporizador()

func _comprar_quebrantos():
	var precio = int(get_node("RecetaQuebrantos/Precio").get_text())
	
	if precio <= dinero:
		dinero -= precio
		get_parent().get_node("Dinero").set_text(str(dinero))
		compradoQuebrantos.show()
		comprarQuebrantos.hide()
		get_parent().get_node("LibroRecetas/Quebrantos").show()
		get_parent().get_node("LibroPrecios/Quebrantos").show()
	else:
		temporizador()
		
func _comprar_olla():
	var precio = int(get_node("RecetaOlla/Precio").get_text())
	
	if precio <= dinero:
		dinero -= precio
		get_parent().get_node("Dinero").set_text(str(dinero))
		compradoOlla.show()
		comprarOlla.hide()
		get_parent().get_node("LibroRecetas/Olla").show()
		get_parent().get_node("LibroPrecios/Olla").show()
	else:
		temporizador()

func _comprar_estofado():
	var precio = int(get_node("RecetaEstofado/Precio").get_text())
	
	if precio <= dinero:
		dinero -= precio
		get_parent().get_node("Dinero").set_text(str(dinero))
		compradoEstofado.show()
		comprarEstofado.hide()
		get_parent().get_node("LibroRecetas/Estofado").show()
		get_parent().get_node("LibroPrecios/Estofado").show()
	else:
		temporizador()
