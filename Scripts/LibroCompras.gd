extends Patch9Frame
#ESte script se utiliza para gestionar todo lo referente al libro de 
#compras, el cual es el que usa para adquirir los permisos de venta
#así como las recetas
var dinero
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
var compras
var mapa
var t

var permiso_cerveceria_comprado = false
var permiso_aperitivos_comprado = false
var permiso_comidas_comprado = false
var receta_quebrantos_comprada = false
var receta_sopa_comprada = false
var receta_olla_comprada = false
var receta_estofado_comprada = false

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
	
	var cerrar = get_node("CerrarCompras")
	mapa = get_parent().get_parent()
	compras = get_parent().get_node("Compras")
	t = Timer.new()
	t.set_one_shot(true)
	self.add_child(t)
	
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
		comprarCerveza.connect("pressed", self, "_comprar", ["Cerveza", int(get_node("PermisoCerveceria/Precio").get_text()), compradoCerveza, comprarCerveza])
	if comprarAperitivos:
		comprarAperitivos.connect("pressed", self, "_comprar", ["Aperitivos", int(get_node("PermisoAperitivos/Precio").get_text()), compradoAperitivos, comprarAperitivos])
	if comprarComida:
		comprarComida.connect("pressed", self, "_comprar", ["Comidas", int(get_node("PermisoComidas/Precio").get_text()), compradoComida, comprarComida])
	if comprarQuebrantos:
		comprarQuebrantos.connect("pressed", self, "_comprar", ["Quebrantos", int(get_node("RecetaQuebrantos/Precio").get_text()), compradoQuebrantos, comprarQuebrantos])
	if comprarSopa:
		comprarSopa.connect("pressed", self, "_comprar", ["Sopa", int(get_node("RecetaSopa/Precio").get_text()), compradoSopa, comprarSopa])
	if comprarOlla:
		comprarOlla.connect("pressed", self, "_comprar", ["Olla", int(get_node("RecetaOlla/Precio").get_text()), compradoOlla, comprarOlla])
	if comprarEstofado:
		comprarEstofado.connect("pressed", self, "_comprar", ["Estofado", int(get_node("RecetaEstofado/Precio").get_text()), compradoEstofado, comprarEstofado])
	pass

func _mostrar_compras():
	#Con esta función lo que hago es que al pulsar el botón "Compras" aparezca
	#el libro de compras, y oculto el resto de botones para que el jugador
	#no los pulse y se superpongan los demás libros
	mostrarCompras = true
	show()
	get_parent().get_node("Dia").set_text("")
	mapa.cerrar_Botones()
	pass

func _cerrar_compras():
	#Esta es igual pero para cerrarlo
	mostrarCompras = false
	hide()
	mapa.mostrar_botones()
	pass

#Esta función se utiliza para hacer la compra de los permisos
#y recetas disponibles
func _comprar(text, precio, comprado, comprar):
	if precio <= dinero:
		dinero -= precio
		get_parent().get_node("Dinero").set_text(str(dinero))
		comprado.show()
		comprar.hide()
		if text == "Cerveza":
			get_parent().get_node("Container/LibroPedidos/Cerveza").show()
			get_parent().get_node("LibroPrecios/Cerveza").show()
			get_parent().get_parent().get_node("Navegacion").menu["res://Scenes/JarraCerveza.tscn"] = Rect2(Vector2(230, 363), Vector2(20, 20))
			get_parent().get_parent().get_node("BarraDetras/Barriles/Barril1").show()
			permiso_cerveceria_comprado = true
		elif text == "Aperitivos":
			get_parent().get_node("Container/LibroPedidos/Pan").show()
			get_parent().get_node("Container/LibroPedidos/Queso").show()
			get_parent().get_node("LibroPrecios/Pan").show()
			get_parent().get_node("LibroPrecios/Queso").show()
			get_parent().get_parent().get_node("Navegacion").menu["res://Scenes/pan.tscn"] = Rect2(Vector2(626, 4), Vector2(44, 42))
			get_parent().get_parent().get_node("Navegacion").menu["res://Scenes/queso.tscn"] = Rect2(Vector2(535, 6), Vector2(35, 35))
			get_parent().get_parent().get_node("BarraDetras/Cajas/CajaPan").show()
			get_parent().get_parent().get_node("BarraDetras/Cajas/CajaQueso").show()
			permiso_aperitivos_comprado = true
		elif text == "Comidas":
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
			get_parent().get_parent().get_node("Navegacion").menu["res://Scenes/carneCocinada.tscn"] = Rect2(Vector2(50, 610), Vector2(32, 32))
			get_parent().get_parent().get_node("Navegacion").menu["res://Scenes/pescadoCocinado.tscn"] = Rect2(Vector2(200, 702), Vector2(48, 32))
			get_parent().get_parent().servir_comida = true
			get_parent().get_parent().get_node("BarraDetras/Cajas/CajaCarne").show()
			get_parent().get_parent().get_node("BarraDetras/Cajas/CajaPescado").show()
			get_parent().get_parent().get_node("BarraDetras/Cajas/CajaVerduras").show()
			get_parent().get_parent().get_node("BarraDetras/Cajas/CajaPatatas").show()
			get_parent().get_parent().get_node("BarraDetras/Cajas/CajaHuevos").show()
			get_parent().get_parent().get_node("BarraDetras/CalderoNode/Caldero").show()
			permiso_comidas_comprado = true
		elif text == "Quebrantos":
			get_parent().get_node("LibroRecetas/Quebrantos").show()
			get_parent().get_node("LibroPrecios/Quebrantos").show()
			get_parent().get_parent().get_node("Navegacion").menu["res://Scenes/quebrantos.tscn"] = Rect2(Vector2(340, 34), Vector2(32, 32))
			get_parent().get_parent().get_node("Hud/ComidaDia").desplegable.add_item("Quebrantos")
			receta_quebrantos_comprada = true
		elif text == "Sopa":
			get_parent().get_node("LibroRecetas/Sopa").show()
			get_parent().get_node("LibroPrecios/Sopa").show()
			get_parent().get_parent().get_node("Navegacion").menu["res://Scenes/sopa.tscn"] = Rect2(Vector2(70, 68), Vector2(32, 32))
			get_parent().get_parent().get_node("Hud/ComidaDia").desplegable.add_item("Sopa")
			receta_sopa_comprada = true
		elif text == "Olla":
			get_parent().get_node("LibroRecetas/Olla").show()
			get_parent().get_node("LibroPrecios/Olla").show()
			get_parent().get_parent().get_node("Navegacion").menu["res://Scenes/olla.tscn"] = Rect2(Vector2(273, 238), Vector2(32, 32))
			get_parent().get_parent().get_node("Hud/ComidaDia").desplegable.add_item("Olla podrida")
			receta_olla_comprada = true
		elif text == "Estofado":
			get_parent().get_node("LibroRecetas/Estofado").show()
			get_parent().get_node("LibroPrecios/Estofado").show()
			get_parent().get_parent().get_node("Navegacion").menu["res://Scenes/estofado.tscn"] = Rect2(Vector2(374, 238), Vector2(32, 32))
			get_parent().get_parent().get_node("Hud/ComidaDia").desplegable.add_item("Estofado")
			receta_estofado_comprada = true
	else:
		insuficiente.show()
		t.set_wait_time(5)
		t.start()
		yield(t, "timeout")
		insuficiente.hide()
	pass

func save():
	var save_dict = {
		_permiso_cerveceria_comprado=permiso_cerveceria_comprado,
		_permiso_aperitivos_comprado=permiso_aperitivos_comprado,
		_permiso_comidas_comprado=permiso_comidas_comprado,
		_receta_quebrantos_comprada=receta_quebrantos_comprada,
		_receta_sopa_comprada=receta_sopa_comprada,
		_receta_olla_comprada=receta_olla_comprada,
		_receta_estofado_comprada=receta_estofado_comprada
	}
	return save_dict