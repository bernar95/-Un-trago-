extends Container
#Este script sirve fundamentalmente para hacer los distintos pedidos
var stock_vino = 0
var stock_cerveza = 0
var stock_carne = 0
var stock_pescado = 0
var stock_verduras = 0
var stock_patatas = 0
var stock_huevos = 0
var stock_pan = 0
var stock_queso = 0

var limite_vino = 90
var limite_cerveza = 90
var limite_carne = 10
var limite_pescado = 10
var limite_verduras = 60
var limite_patatas = 80
var limite_huevos = 24
var limite_pan = 20
var limite_queso = 20

var pedidos
var mostrarPedidos = false
var mapa
var tiempo = Timer.new()

func _ready():
	hide()

	pedidos = get_parent().get_node("Pedidos")
	var cerrar = get_node("LibroPedidos/CerrarPedidos")
	var hacer_pedido = get_node("LibroPedidos/HacerPedido")
	mapa = get_parent().get_parent()
	tiempo.set_one_shot(true)
	self.add_child(tiempo)
	
	if pedidos:
		pedidos.connect("pressed", self, "_mostrar_pedidos")
	if cerrar:
		cerrar.connect("pressed", self, "_cerrar_pedidos")
	if hacer_pedido:
		hacer_pedido.connect("pressed", self, "_hacer_pedido")

func _mostrar_pedidos():
	get_parent().get_parent().get_node("Sonidos/SamplePlayer2D").play("Abrir_libro", 10)
	tiempo.set_wait_time(0.5)
	tiempo.start()
	yield(tiempo, "timeout")
	mostrarPedidos = true
	show()
	get_parent().get_node("Dia").set_text("")
	mapa.cerrar_Botones()
	pass

func _cerrar_pedidos():
	get_parent().get_parent().get_node("Sonidos/SamplePlayer2D").play("Cerrar_libro", 10)
	tiempo.set_wait_time(0.25)
	tiempo.start()
	yield(tiempo, "timeout")
	mostrarPedidos = false
	hide()
	mapa.mostrar_botones()
	get_node("LibroPedidos/LimiteSuperado").hide()
	get_node("LibroPedidos/LimiteSuperado/LimiteVinoSuperado").hide()
	get_node("LibroPedidos/LimiteSuperado/LimiteCervezaSuperado").hide()
	get_node("LibroPedidos/LimiteSuperado/LimiteCarneSuperado").hide()
	get_node("LibroPedidos/LimiteSuperado/LimitePescadoSuperado").hide()
	get_node("LibroPedidos/LimiteSuperado/LimiteVerdurasSuperado").hide()
	get_node("LibroPedidos/LimiteSuperado/LimitePatatasSuperado").hide()
	get_node("LibroPedidos/LimiteSuperado/LimiteHuevosSuperado").hide()
	get_node("LibroPedidos/LimiteSuperado/LimitePanSuperado").hide()
	get_node("LibroPedidos/LimiteSuperado/LimiteQuesoSuperado").hide()
	pass
	
#Esta función sirve para hacer un pedido(como su nombre indica). Tiene en cuenta
#varias cosas. Comprueba para cada uno de los items que no supera el límite
#de stock disponible en la taberna. Después comprueba que el valor de los items 
#a comprar no supera el dinero total del que dispone el jugador, y si se cumple
#todo eso, va sumando a los determinados stocks de productos la cantidad comprada
#de cada uno(si se ha comprado algo) y por último resta el valor de la compra
#al dinero total
func _hacer_pedido():
	var dinero = int(get_parent().get_node("Dinero").get_text())
	var pago = int(get_node("LibroPedidos/TotalPagarLabel/TotalPagar").get_text())
	
	var cantidad_vino = 30 * get_node("LibroPedidos").cantidad_vino + stock_vino
	var cantidad_cerveza = 30 * get_node("LibroPedidos").cantidad_cerveza + stock_cerveza
	var cantidad_carne = get_node("LibroPedidos").cantidad_carne + stock_carne
	var cantidad_pescado = get_node("LibroPedidos").cantidad_pescado + stock_pescado
	var cantidad_verduras = 10 * get_node("LibroPedidos").cantidad_verduras + stock_verduras
	var cantidad_patatas = 20 * get_node("LibroPedidos").cantidad_patatas + stock_patatas
	var cantidad_huevos = get_node("LibroPedidos").cantidad_huevos + stock_huevos
	var cantidad_pan = 4 * get_node("LibroPedidos").cantidad_pan + stock_pan
	var cantidad_queso = 4 * get_node("LibroPedidos").cantidad_queso + stock_queso
	if cantidad_vino > limite_vino:
		get_node("LibroPedidos/LimiteSuperado").show()
		get_node("LibroPedidos/LimiteSuperado/LimiteVinoSuperado").show()
	if cantidad_vino <= limite_vino:
		get_node("LibroPedidos/LimiteSuperado/LimiteVinoSuperado").hide()
	if cantidad_cerveza > limite_cerveza:
		get_node("LibroPedidos/LimiteSuperado").show()
		get_node("LibroPedidos/LimiteSuperado/LimiteCervezaSuperado").show()
	if cantidad_cerveza <= limite_cerveza:
		get_node("LibroPedidos/LimiteSuperado/LimiteCervezaSuperado").hide()
	if cantidad_carne > limite_carne:
		get_node("LibroPedidos/LimiteSuperado").show()
		get_node("LibroPedidos/LimiteSuperado/LimiteCarneSuperado").show()
	if cantidad_carne <= limite_carne:
		get_node("LibroPedidos/LimiteSuperado/LimiteCarneSuperado").hide()
	if cantidad_pescado > limite_pescado:
		get_node("LibroPedidos/LimiteSuperado").show()
		get_node("LibroPedidos/LimiteSuperado/LimitePescadoSuperado").show()
	if cantidad_pescado <= limite_pescado:
		get_node("LibroPedidos/LimiteSuperado/LimitePescadoSuperado").hide()
	if cantidad_verduras > limite_verduras:
		get_node("LibroPedidos/LimiteSuperado").show()
		get_node("LibroPedidos/LimiteSuperado/LimiteVerdurasSuperado").show()
	if cantidad_verduras <= limite_verduras:
		get_node("LibroPedidos/LimiteSuperado/LimiteVerdurasSuperado").hide()
	if cantidad_patatas > limite_patatas:
		get_node("LibroPedidos/LimiteSuperado").show()
		get_node("LibroPedidos/LimiteSuperado/LimitePatatasSuperado").show()
	if cantidad_patatas <= limite_patatas:
		get_node("LibroPedidos/LimiteSuperado/LimitePatatasSuperado").hide()
	if cantidad_huevos > limite_huevos:
		get_node("LibroPedidos/LimiteSuperado").show()
		get_node("LibroPedidos/LimiteSuperado/LimiteHuevosSuperado").show()
	if cantidad_huevos <= limite_huevos:
		get_node("LibroPedidos/LimiteSuperado/LimiteHuevosSuperado").hide()
	if cantidad_pan > limite_pan:
		get_node("LibroPedidos/LimiteSuperado").show()
		get_node("LibroPedidos/LimiteSuperado/LimitePanSuperado").show()
	if cantidad_pan <= limite_pan:
		get_node("LibroPedidos/LimiteSuperado/LimitePanSuperado").hide()
	if cantidad_queso > limite_queso:
		get_node("LibroPedidos/LimiteSuperado").show()
		get_node("LibroPedidos/LimiteSuperado/LimiteQuesoSuperado").show()
	if cantidad_queso <= limite_queso:
		get_node("LibroPedidos/LimiteSuperado/LimiteQuesoSuperado").hide()
	if cantidad_vino <= limite_vino and cantidad_cerveza <= limite_cerveza and cantidad_carne <= limite_carne and cantidad_pescado <= limite_pescado and cantidad_verduras <= limite_verduras and cantidad_patatas <= limite_patatas and cantidad_huevos <= limite_huevos and cantidad_pan <= limite_pan and cantidad_queso <= limite_queso:
		get_node("LibroPedidos/LimiteSuperado").hide()
		if pago <= dinero:
			dinero -= pago
			get_parent().get_node("Dinero").set_text(str(dinero))
			
			get_node("LibroPedidos/TotalPagarLabel/TotalPagar").set_text("0")
			get_parent().get_parent().get_node("Sonidos/SamplePlayer2D").play("Pagar", 4)
			if get_node("LibroPedidos").cantidad_carne > 0:
				var cantidad = get_node("LibroPedidos").cantidad_carne
				stock_carne += cantidad
				var text = str(stock_carne) + "/10"
				get_parent().get_node("LibroSuministros/ContainerCarne/StockCarne").set_text(text)
				var spriteCarne = preload("res://Scenes/carne.tscn")
				var carne = spriteCarne.instance()
				carne.set_pos(Vector2(290, 42))
				get_parent().get_parent().get_node("BarraDetras/Alimentos/Carne").add_child(carne)
				get_node("LibroPedidos").cantidad_carne = 0
				get_node("LibroPedidos/MenosCarne").hide()
				get_node("LibroPedidos/LabelCarne").set_text("")
				get_node("LibroPedidos/CantidadCarne").set_text("")
				get_parent().get_parent().get_node("BarraDetras/Cajas").carne = true
		
			if get_node("LibroPedidos").cantidad_pescado > 0:
				var cantidad = get_node("LibroPedidos").cantidad_pescado
				stock_pescado += cantidad
				var text = str(stock_pescado) + "/10"
				get_parent().get_node("LibroSuministros/ContainerPescado/StockPescado").set_text(text)
				var spritePescado = preload("res://Scenes/pescado.tscn")
				var pescado = spritePescado.instance()
				pescado.set_pos(Vector2(640, 42))
				get_parent().get_parent().get_node("BarraDetras/Alimentos/Pescado").add_child(pescado)
				get_node("LibroPedidos").cantidad_pescado = 0
				get_node("LibroPedidos/MenosPescado").hide()
				get_node("LibroPedidos/LabelPescado").set_text("")
				get_node("LibroPedidos/CantidadPescado").set_text("")
				get_parent().get_parent().get_node("BarraDetras/Cajas").pescado = true
		
			if get_node("LibroPedidos").cantidad_queso > 0:
				var cantidad = 4 * get_node("LibroPedidos").cantidad_queso
				stock_queso += cantidad
				var text = str(stock_queso) + "/20"
				get_parent().get_node("LibroSuministros/ContainerQueso/StockQueso").set_text(text)
				var spriteQueso = preload("res://Scenes/queso.tscn")
				var queso = spriteQueso.instance()
				queso.set_pos(Vector2(672, 42))
				get_parent().get_parent().get_node("BarraDetras/Alimentos/Queso").add_child(queso)
				get_node("LibroPedidos").cantidad_queso = 0
				get_node("LibroPedidos/MenosQueso").hide()
				get_node("LibroPedidos/LabelQueso").set_text("")
				get_node("LibroPedidos/CantidadQueso").set_text("")
				get_parent().get_parent().get_node("BarraDetras/Cajas").queso = true
		
			if get_node("LibroPedidos").cantidad_verduras > 0:
				var cantidad = 10 * get_node("LibroPedidos").cantidad_verduras
				stock_verduras += cantidad
				var text = str(stock_verduras) + "/60"
				get_parent().get_node("LibroSuministros/ContainerVerduras/StockVerduras").set_text(text)
				var spriteVerduras = preload("res://Scenes/verduras.tscn")
				var verduras = spriteVerduras.instance()
				verduras.set_pos(Vector2(704, 42))
				get_parent().get_parent().get_node("BarraDetras/Alimentos/Verduras").add_child(verduras)
				get_node("LibroPedidos").cantidad_verduras = 0
				get_node("LibroPedidos/MenosVerdura").hide()
				get_node("LibroPedidos/LabelVerduras").set_text("")
				get_node("LibroPedidos/CantidadVerduras").set_text("")
				get_parent().get_parent().get_node("BarraDetras/Cajas").verduras = true
			
			if get_node("LibroPedidos").cantidad_patatas > 0:
				var cantidad = 20 * get_node("LibroPedidos").cantidad_patatas
				stock_patatas += cantidad
				var text = str(stock_patatas) + "/80"
				get_parent().get_node("LibroSuministros/ContainerPatatas/StockPatatas").set_text(text)
				var spritePatatas = preload("res://Scenes/patatas.tscn")
				var patatas = spritePatatas.instance()
				patatas.set_pos(Vector2(736, 42))
				get_parent().get_parent().get_node("BarraDetras/Alimentos/Patatas").add_child(patatas)
				get_node("LibroPedidos").cantidad_patatas = 0
				get_node("LibroPedidos/MenosPatatas").hide()
				get_node("LibroPedidos/LabelPatatas").set_text("")
				get_node("LibroPedidos/CantidadPatatas").set_text("")
				get_parent().get_parent().get_node("BarraDetras/Cajas").patatas = true
		
			if get_node("LibroPedidos").cantidad_pan > 0:
				var cantidad = 4 * get_node("LibroPedidos").cantidad_pan
				stock_pan += cantidad
				var text = str(stock_pan) + "/20"
				get_parent().get_node("LibroSuministros/ContainerPan/StockPan").set_text(text)
				var spritePan = preload("res://Scenes/pan.tscn")
				var pan = spritePan.instance()
				pan.set_pos(Vector2(512, 26))
				get_parent().get_parent().get_node("BarraDetras/Alimentos/Pan").add_child(pan)
				get_node("LibroPedidos").cantidad_pan = 0
				get_node("LibroPedidos/MenosPan").hide()
				get_node("LibroPedidos/LabelPan").set_text("")
				get_node("LibroPedidos/CantidadPan").set_text("")
				get_parent().get_parent().get_node("BarraDetras/Cajas").pan = true
		
			if get_node("LibroPedidos").cantidad_huevos > 0:
				var cantidad = get_node("LibroPedidos").cantidad_huevos
				stock_huevos += cantidad
				var text = str(stock_huevos) + "/24"
				get_parent().get_node("LibroSuministros/ContainerHuevos/StockHuevos").set_text(text)
				var spriteHuevos = preload("res://Scenes/huevos.tscn")
				var huevos = spriteHuevos.instance()
				huevos.set_pos(Vector2(544, 26))
				get_parent().get_parent().get_node("BarraDetras/Alimentos/Huevos").add_child(huevos)
				get_node("LibroPedidos").cantidad_huevos = 0
				get_node("LibroPedidos/MenosHuevos").hide()
				get_node("LibroPedidos/LabelHuevo").set_text("")
				get_node("LibroPedidos/CantidadHuevo").set_text("")
				get_parent().get_parent().get_node("BarraDetras/Cajas").huevos = true
		
			if get_node("LibroPedidos").cantidad_vino > 0:
				var cantidad = 30 * get_node("LibroPedidos").cantidad_vino
				stock_vino += cantidad
				var text = str(stock_vino) + "/90"
				get_parent().get_node("LibroSuministros/ContainerVino/StockVino").set_text(text)
				get_node("LibroPedidos").cantidad_vino = 0
				get_node("LibroPedidos/MenosVino").hide()
				get_node("LibroPedidos/LabelVino").set_text("")
				get_node("LibroPedidos/CantidadVino").set_text("")
		
			if get_node("LibroPedidos").cantidad_cerveza > 0:
				var cantidad = 30 * get_node("LibroPedidos").cantidad_cerveza
				stock_cerveza += cantidad
				var text = str(stock_cerveza) + "/90"
				get_parent().get_node("LibroSuministros/ContainerCerveza/StockCerveza").set_text(text)
				get_node("LibroPedidos").cantidad_cerveza = 0
				get_node("LibroPedidos/MenosCerveza").hide()
				get_node("LibroPedidos/LabelCerveza").set_text("")
				get_node("LibroPedidos/CantidadCerveza").set_text("")
		else:
			get_node("LibroPedidos/InsuficienteDinero").show()
			var t = Timer.new()
			t.set_wait_time(5)
			t.set_one_shot(true)
			self.add_child(t)
			t.start()
			yield(t, "timeout")
			get_node("LibroPedidos/InsuficienteDinero").hide()
	pass

func save():
	var save_dict = {
		_stock_vino=stock_vino,
		_stock_cerveza=stock_cerveza,
		_stock_carne=stock_carne,
		_stock_pescado=stock_pescado,
		_stock_verduras=stock_verduras,
		_stock_patatas=stock_patatas,
		_stock_huevos=stock_huevos,
		_stock_pan=stock_pan,
		_stock_queso=stock_queso
	}
	return save_dict