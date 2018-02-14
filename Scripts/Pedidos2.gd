extends Container

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

func _ready():
	hide()

	var pedidos = get_parent().get_node("Pedidos")
	var cerrar = get_node("LibroPedidos/CerrarPedidos")
	var hacer_pedido = get_node("LibroPedidos/HacerPedido")
	
	if pedidos:
		pedidos.connect("pressed", self, "_mostrar_pedidos")
	if cerrar:
		cerrar.connect("pressed", self, "_cerrar_pedidos")
	if hacer_pedido:
		hacer_pedido.connect("pressed", self, "_hacer_pedido")

func _mostrar_pedidos():
	show()
	pass

func _cerrar_pedidos():
	hide()
	pass

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
	var cantidad_pan = get_node("LibroPedidos").cantidad_pan + stock_pan
	var cantidad_queso = get_node("LibroPedidos").cantidad_queso + stock_queso
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
		
			if get_node("LibroPedidos").cantidad_carne > 0:
				var cantidad = get_node("LibroPedidos").cantidad_carne
				stock_carne += cantidad
				var text = str(stock_carne) + "/10"
				get_parent().get_node("LibroSuministros/ContainerCarne/StockCarne").set_text(text)
				var spriteCarne = preload("res://Scenes/carne.tscn")
				var carne = spriteCarne.instance()
				carne.set_pos(Vector2(290, 42))
				get_parent().get_parent().get_node("Alimentos").add_child(carne)
				get_node("LibroPedidos").cantidad_carne = 0
				get_node("LibroPedidos/MenosCarne").hide()
				get_node("LibroPedidos/LabelCarne").set_text("")
				get_node("LibroPedidos/CantidadCarne").set_text("")
		
			if get_node("LibroPedidos").cantidad_pescado > 0:
				var cantidad = get_node("LibroPedidos").cantidad_pescado
				stock_pescado += cantidad
				var text = str(stock_pescado) + "/10"
				get_parent().get_node("LibroSuministros/ContainerPescado/StockPescado").set_text(text)
				var spritePescado = preload("res://Scenes/pescado.tscn")
				var pescado = spritePescado.instance()
				pescado.set_pos(Vector2(640, 42))
				get_parent().get_parent().get_node("Alimentos").add_child(pescado)
				get_node("LibroPedidos").cantidad_pescado = 0
				get_node("LibroPedidos/MenosPescado").hide()
				get_node("LibroPedidos/LabelPescado").set_text("")
				get_node("LibroPedidos/CantidadPescado").set_text("")
		
			if get_node("LibroPedidos").cantidad_queso > 0:
				var cantidad = get_node("LibroPedidos").cantidad_queso
				stock_queso += cantidad
				var text = str(stock_queso) + "/20"
				get_parent().get_node("LibroSuministros/ContainerQueso/StockQueso").set_text(text)
				var spriteQueso = preload("res://Scenes/queso.tscn")
				var queso = spriteQueso.instance()
				queso.set_pos(Vector2(672, 42))
				get_parent().get_parent().get_node("Alimentos").add_child(queso)
				get_node("LibroPedidos").cantidad_queso = 0
				get_node("LibroPedidos/MenosQueso").hide()
				get_node("LibroPedidos/LabelQueso").set_text("")
				get_node("LibroPedidos/CantidadQueso").set_text("")
		
			if get_node("LibroPedidos").cantidad_verduras > 0:
				var cantidad = 10 * get_node("LibroPedidos").cantidad_verduras
				stock_verduras += cantidad
				var text = str(stock_verduras) + "/60"
				get_parent().get_node("LibroSuministros/ContainerVerduras/StockVerduras").set_text(text)
				var spriteVerduras = preload("res://Scenes/verduras.tscn")
				var verduras = spriteVerduras.instance()
				verduras.set_pos(Vector2(704, 42))
				get_parent().get_parent().get_node("Alimentos").add_child(verduras)
				get_node("LibroPedidos").cantidad_verduras = 0
				get_node("LibroPedidos/MenosVerdura").hide()
				get_node("LibroPedidos/LabelVerduras").set_text("")
				get_node("LibroPedidos/CantidadVerduras").set_text("")
			
			if get_node("LibroPedidos").cantidad_patatas > 0:
				var cantidad = 20 * get_node("LibroPedidos").cantidad_patatas
				stock_patatas += cantidad
				var text = str(stock_patatas) + "/80"
				get_parent().get_node("LibroSuministros/ContainerPatatas/StockPatatas").set_text(text)
				var spritePatatas = preload("res://Scenes/patatas.tscn")
				var patatas = spritePatatas.instance()
				patatas.set_pos(Vector2(736, 42))
				get_parent().get_parent().get_node("Alimentos").add_child(patatas)
				get_node("LibroPedidos").cantidad_patatas = 0
				get_node("LibroPedidos/MenosPatatas").hide()
				get_node("LibroPedidos/LabelPatatas").set_text("")
				get_node("LibroPedidos/CantidadPatatas").set_text("")
		
			if get_node("LibroPedidos").cantidad_pan > 0:
				var cantidad = get_node("LibroPedidos").cantidad_pan
				stock_pan += cantidad
				var text = str(stock_pan) + "/20"
				get_parent().get_node("LibroSuministros/ContainerPan/StockPan").set_text(text)
				var spritePan = preload("res://Scenes/pan.tscn")
				var pan = spritePan.instance()
				pan.set_pos(Vector2(512, 26))
				get_parent().get_parent().get_node("Alimentos").add_child(pan)
				get_node("LibroPedidos").cantidad_pan = 0
				get_node("LibroPedidos/MenosPan").hide()
				get_node("LibroPedidos/LabelPan").set_text("")
				get_node("LibroPedidos/CantidadPan").set_text("")
		
			if get_node("LibroPedidos").cantidad_huevos > 0:
				var cantidad = get_node("LibroPedidos").cantidad_huevos
				stock_huevos += cantidad
				var text = str(stock_huevos) + "/24"
				get_parent().get_node("LibroSuministros/ContainerHuevos/StockHuevos").set_text(text)
				var spriteHuevos = preload("res://Scenes/huevos.tscn")
				var huevos = spriteHuevos.instance()
				huevos.set_pos(Vector2(544, 26))
				get_parent().get_parent().get_node("Alimentos").add_child(huevos)
				get_node("LibroPedidos").cantidad_huevos = 0
				get_node("LibroPedidos/MenosHuevos").hide()
				get_node("LibroPedidos/LabelHuevo").set_text("")
				get_node("LibroPedidos/CantidadHuevo").set_text("")
		
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
			t.set_wait_time(3)
			t.set_one_shot(true)
			self.add_child(t)
			t.start()
			yield(t, "timeout")
			get_node("LibroPedidos/InsuficienteDinero").hide()
	pass