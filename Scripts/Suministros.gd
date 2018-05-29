extends Patch9Frame
#Este scrip sirve para añadir o quitar items a un pedido
var cantidad_vino = 0
var cantidad_cerveza = 0
var cantidad_carne = 0
var cantidad_pescado = 0
var cantidad_verduras = 0
var cantidad_patatas = 0
var cantidad_huevos = 0
var cantidad_pan = 0
var cantidad_queso = 0

func _ready():
	var vino = get_node("ComprarVino")
	if vino:
		vino.connect("pressed", self, "_comprar", ["Vino", get_node("LabelVino"), get_node("CantidadVino"), int(get_node("Precio/Vino").get_text())])
	var cerveza = get_node("Cerveza/ComprarCerveza")
	if cerveza:
		cerveza.connect("pressed", self, "_comprar", ["Cerveza", get_node("LabelCerveza"), get_node("CantidadCerveza"), int(get_node("Cerveza/Precio1/Cerveza").get_text())])
	var carne = get_node("Carne/ComprarCarne")
	if carne:
		carne.connect("pressed", self, "_comprar", ["Carne", get_node("LabelCarne"), get_node("CantidadCarne"), int(get_node("Carne/Precio2/Carne").get_text())])
	var pescado = get_node("Pescado/ComprarPescado")
	if pescado:
		pescado.connect("pressed", self, "_comprar", ["Pescado", get_node("LabelPescado"), get_node("CantidadPescado"), int(get_node("Pescado/Precio3/Pescado").get_text())])
	var verduras = get_node("Verduras/ComprarVerduras")
	if verduras:
		verduras.connect("pressed", self, "_comprar", ["Verduras", get_node("LabelVerduras"), get_node("CantidadVerduras"), int(get_node("Verduras/Precio4/Verduras").get_text())])
	var patatas = get_node("Patatas/ComprarPatatas")
	if patatas:
		patatas.connect("pressed", self, "_comprar", ["Patatas", get_node("LabelPatatas"), get_node("CantidadPatatas"), int(get_node("Patatas/Precio5/Patatas").get_text())])
	var huevo = get_node("Huevos/ComprarHuevos")
	if huevo:
		huevo.connect("pressed", self, "_comprar", ["Huevos", get_node("LabelHuevo"), get_node("CantidadHuevo"), int(get_node("Huevos/Precio6/Huevo").get_text())])
	var pan = get_node("Pan/ComprarPan")
	if pan:
		pan.connect("pressed", self, "_comprar", ["Pan", get_node("LabelPan"), get_node("CantidadPan"), int(get_node("Pan/Precio7/Pan").get_text())])
	var queso = get_node("Queso/ComprarQueso")
	if queso:
		queso.connect("pressed", self, "_comprar", ["Queso", get_node("LabelQueso"), get_node("CantidadQueso"), int(get_node("Queso/Precio8/Queso").get_text())])
	var menos_vino = get_node("MenosVino")
	if menos_vino:
		menos_vino.connect("pressed", self, "_menos", ["Vino", get_node("LabelVino"), get_node("CantidadVino"), int(get_node("Precio/Vino").get_text())])
	var menos_cerveza = get_node("MenosCerveza")
	if menos_cerveza:
		menos_cerveza.connect("pressed", self, "_menos", ["Cerveza", get_node("LabelCerveza"), get_node("CantidadCerveza"), int(get_node("Cerveza/Precio1/Cerveza").get_text())])
	var menos_carne = get_node("MenosCarne")
	if menos_carne:
		menos_carne.connect("pressed", self, "_menos", ["Carne", get_node("LabelCarne"), get_node("CantidadCarne"), int(get_node("Carne/Precio2/Carne").get_text())])
	var menos_pescado = get_node("MenosPescado")
	if menos_pescado:
		menos_pescado.connect("pressed", self, "_menos", ["Pescado", get_node("LabelPescado"), get_node("CantidadPescado"), int(get_node("Pescado/Precio3/Pescado").get_text())])
	var menos_verdura = get_node("MenosVerdura")
	if menos_verdura:
		menos_verdura.connect("pressed", self, "_menos", ["Verduras", get_node("LabelVerduras"), get_node("CantidadVerduras"), int(get_node("Verduras/Precio4/Verduras").get_text())])
	var menos_patatas = get_node("MenosPatatas")
	if menos_patatas:
		menos_patatas.connect("pressed", self, "_menos", ["Patatas", get_node("LabelPatatas"), get_node("CantidadPatatas"), int(get_node("Patatas/Precio5/Patatas").get_text())])
	var menos_huevos = get_node("MenosHuevos")
	if menos_huevos:
		menos_huevos.connect("pressed", self, "_menos", ["Huevos", get_node("LabelHuevo"), get_node("CantidadHuevo"), int(get_node("Huevos/Precio6/Huevo").get_text())])
	var menos_pan = get_node("MenosPan")
	if menos_pan:
		menos_pan.connect("pressed", self, "_menos", ["Pan", get_node("LabelPan"), get_node("CantidadPan"), int(get_node("Pan/Precio7/Pan").get_text())])
	var menos_queso = get_node("MenosQueso")
	if menos_queso:
		menos_queso.connect("pressed", self, "_menos", ["Queso", get_node("LabelQueso"), get_node("CantidadQueso"), int(get_node("Queso/Precio8/Queso").get_text())])

	get_node("Cerveza").hide()
	get_node("Carne").hide()
	get_node("Pescado").hide()
	get_node("Verduras").hide()
	get_node("Patatas").hide()
	get_node("Pan").hide()
	get_node("Queso").hide()
	get_node("Huevos").hide()
	pass
#Esta función sirve para que cada vez que el jugador
#pulse un botón de comprar un ítem, se añada una unidad de dicho item al pedido,
#y para que se vaya añadiendo a la variable "total_pagar" el valor de cada 
#unidad de dicho item
func _comprar(text, label, label_cantidad, precio):
	var cantidad
	var total_pagar = int(get_node("TotalPagarLabel/TotalPagar").get_text())
	label.set_text(text)
	if text == "Vino":
		cantidad_vino += 1
		cantidad = cantidad_vino
		get_node("MenosVino").show()
	elif text == "Cerveza":
		cantidad_cerveza += 1
		cantidad = cantidad_cerveza
		get_node("MenosCerveza").show()
	elif text == "Carne":
		cantidad_carne += 1
		cantidad = cantidad_carne
		get_node("MenosCarne").show()
	elif text == "Pescado":
		cantidad_pescado += 1
		cantidad = cantidad_pescado
		get_node("MenosPescado").show()
	elif text == "Verduras":
		cantidad_verduras += 1
		cantidad = cantidad_verduras
		get_node("MenosVerdura").show()
	elif text == "Patatas":
		cantidad_patatas += 1
		cantidad = cantidad_patatas
		get_node("MenosPatatas").show()
	elif text == "Huevos":
		cantidad_huevos += 1
		cantidad = cantidad_huevos
		get_node("MenosHuevos").show()
	elif text == "Pan":
		cantidad_pan += 1
		cantidad = cantidad_pan
		get_node("MenosPan").show()
	elif text == "Queso":
		cantidad_queso += 1
		cantidad = cantidad_queso
		get_node("MenosQueso").show()
	label_cantidad.set_text(str(cantidad))
	total_pagar += precio
	get_node("TotalPagarLabel/TotalPagar").set_text(str(total_pagar))
	pass
#Esta función sirve para que cada vez que el jugador
#pulse el botón de quitar un ítem, se quite una unidad de dicho item del pedido,
#y para que se vaya restando a la variable "total_pagar" el valor de cada 
#unidad de dicho item
func _menos(text, label, label_cantidad, precio):
	var cantidad
	var total_pagar = int(get_node("TotalPagarLabel/TotalPagar").get_text())
	if text == "Vino":
		cantidad_vino -= 1
		cantidad = cantidad_vino
	elif text == "Cerveza":
		cantidad_cerveza -= 1
		cantidad = cantidad_cerveza
	elif text == "Carne":
		cantidad_carne -= 1
		cantidad = cantidad_carne
	elif text == "Pescado":
		cantidad_pescado -= 1
		cantidad = cantidad_pescado
	elif text == "Verduras":
		cantidad_verduras -= 1
		cantidad = cantidad_verduras
	elif text == "Patatas":
		cantidad_patatas -= 1
		cantidad = cantidad_patatas
	elif text == "Huevos":
		cantidad_huevos -= 1
		cantidad = cantidad_huevos
	elif text == "Pan":
		cantidad_pan -= 1
		cantidad = cantidad_pan
	elif text == "Queso":
		cantidad_queso -= 1
		cantidad = cantidad_queso
	label_cantidad.set_text(str(cantidad))
	total_pagar -= precio
	get_node("TotalPagarLabel/TotalPagar").set_text(str(total_pagar))
	if cantidad < 1:
		label.set_text("")
		label_cantidad.set_text("")
		cantidad = ""
		if text == "Vino":
			get_node("MenosVino").hide()
			get_parent().get_node("LibroPedidos/LimiteSuperado/LimiteVinoSuperado").hide()
		elif text == "Cerveza":
			get_node("MenosCerveza").hide()
			get_parent().get_node("LibroPedidos/LimiteSuperado/LimiteCervezaSuperado").hide()
		elif text == "Carne":
			get_node("MenosCarne").hide()
			get_parent().get_node("LibroPedidos/LimiteSuperado/LimiteCarneSuperado").hide()
		elif text == "Pescado":
			get_node("MenosPescado").hide()
			get_parent().get_node("LibroPedidos/LimiteSuperado/LimitePescadoSuperado").hide()
		elif text == "Verduras":
			get_node("MenosVerdura").hide()
			get_parent().get_node("LibroPedidos/LimiteSuperado/LimiteVerdurasSuperado").hide()
		elif text == "Patatas":
			get_node("MenosPatatas").hide()
			get_parent().get_node("LibroPedidos/LimiteSuperado/LimitePatatasSuperado").hide()
		elif text == "Huevos":
			get_node("MenosHuevos").hide()
			get_parent().get_node("LibroPedidos/LimiteSuperado/LimiteHuevosSuperado").hide()
		elif text == "Pan":
			get_node("MenosPan").hide()
			get_parent().get_node("LibroPedidos/LimiteSuperado/LimitePanSuperado").hide()
		elif text == "Queso":
			get_node("MenosQueso").hide()
			get_parent().get_node("LibroPedidos/LimiteSuperado/LimiteQuesoSuperado").hide()
	pass