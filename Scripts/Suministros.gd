extends Patch9Frame

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
		vino.connect("pressed", self, "_comprar_vino")
	var cerveza = get_node("ComprarCerveza")
	if cerveza:
		cerveza.connect("pressed", self, "_comprar_cerveza")
	var carne = get_node("ComprarCarne")
	if carne:
		carne.connect("pressed", self, "_comprar_carne")
	var pescado = get_node("ComprarPescado")
	if pescado:
		pescado.connect("pressed", self, "_comprar_pescado")
	var verduras = get_node("ComprarVerduras")
	if verduras:
		verduras.connect("pressed", self, "_comprar_verduras")
	var patatas = get_node("ComprarPatatas")
	if patatas:
		patatas.connect("pressed", self, "_comprar_patatas")
	var huevo = get_node("ComprarHuevos")
	if huevo:
		huevo.connect("pressed", self, "_comprar_huevos")
	var pan = get_node("ComprarPan")
	if pan:
		pan.connect("pressed", self, "_comprar_pan")
	var queso = get_node("ComprarQueso")
	if queso:
		queso.connect("pressed", self, "_comprar_queso")
	var menos_vino = get_node("MenosVino")
	if menos_vino:
		menos_vino.connect("pressed", self, "_menos_vino")
	var menos_cerveza = get_node("MenosCerveza")
	if menos_cerveza:
		menos_cerveza.connect("pressed", self, "_menos_cerveza")
	var menos_carne = get_node("MenosCarne")
	if menos_carne:
		menos_carne.connect("pressed", self, "_menos_carne")
	var menos_pescado = get_node("MenosPescado")
	if menos_pescado:
		menos_pescado.connect("pressed", self, "_menos_pescado")
	var menos_verdura = get_node("MenosVerdura")
	if menos_verdura:
		menos_verdura.connect("pressed", self, "_menos_verdura")
	var menos_patatas = get_node("MenosPatatas")
	if menos_patatas:
		menos_patatas.connect("pressed", self, "_menos_patatas")
	var menos_huevos = get_node("MenosHuevos")
	if menos_huevos:
		menos_huevos.connect("pressed", self, "_menos_huevos")
	var menos_pan = get_node("MenosPan")
	if menos_pan:
		menos_pan.connect("pressed", self, "_menos_pan")
	var menos_queso = get_node("MenosQueso")
	if menos_queso:
		menos_queso.connect("pressed", self, "_menos_queso")
	pass
	

func _comprar_vino():
	var text = "Vino"
	var vino_label = get_node("LabelVino")
	var label_cantidad_vino = get_node("CantidadVino")
	var total_pagar = int(get_node("TotalPagarLabel/TotalPagar").get_text())
	var precio_vino = int(get_node("Precio/Vino").get_text())
	vino_label.set_text(text)
	cantidad_vino += 1
	label_cantidad_vino.set_text(str(cantidad_vino))
	total_pagar += precio_vino
	get_node("TotalPagarLabel/TotalPagar").set_text(str(total_pagar))
	get_node("MenosVino").show()
	pass
	
func _comprar_cerveza():
	var text = "Cerveza"
	var cerveza_label = get_node("LabelCerveza")
	var label_cantidad_cerveza = get_node("CantidadCerveza")
	var total_pagar = int(get_node("TotalPagarLabel/TotalPagar").get_text())
	var precio_cerveza = int(get_node("Precio1/Cerveza").get_text())
	cerveza_label.set_text(text)
	cantidad_cerveza += 1
	label_cantidad_cerveza.set_text(str(cantidad_cerveza))
	total_pagar += precio_cerveza
	get_node("TotalPagarLabel/TotalPagar").set_text(str(total_pagar))
	get_node("MenosCerveza").show()
	pass
	
func _comprar_carne():
	var text = "Carne"
	var carne_label = get_node("LabelCarne")
	var label_cantidad_carne = get_node("CantidadCarne")
	var total_pagar = int(get_node("TotalPagarLabel/TotalPagar").get_text())
	var precio_carne = int(get_node("Precio2/Carne").get_text())
	carne_label.set_text(text)
	cantidad_carne += 1
	label_cantidad_carne.set_text(str(cantidad_carne))
	total_pagar += precio_carne
	get_node("TotalPagarLabel/TotalPagar").set_text(str(total_pagar))
	get_node("MenosCarne").show()
	pass
	
func _comprar_pescado():
	var text = "Pescado"
	var pescado_label = get_node("LabelPescado")
	var label_cantidad_pescado = get_node("CantidadPescado")
	var total_pagar = int(get_node("TotalPagarLabel/TotalPagar").get_text())
	var precio_pescado = int(get_node("Precio3/Pescado").get_text())
	pescado_label.set_text(text)
	cantidad_pescado += 1
	label_cantidad_pescado.set_text(str(cantidad_pescado))
	total_pagar += precio_pescado
	get_node("TotalPagarLabel/TotalPagar").set_text(str(total_pagar))
	get_node("MenosPescado").show()
	pass

func _comprar_verduras():
	var text = "Verduras"
	var verduras_label = get_node("LabelVerduras")
	var label_cantidad_verduras = get_node("CantidadVerduras")
	var total_pagar = int(get_node("TotalPagarLabel/TotalPagar").get_text())
	var precio_verduras = int(get_node("Precio4/Verduras").get_text())
	verduras_label.set_text(text)
	cantidad_verduras += 1
	label_cantidad_verduras.set_text(str(cantidad_verduras))
	total_pagar += precio_verduras
	get_node("TotalPagarLabel/TotalPagar").set_text(str(total_pagar))
	get_node("MenosVerdura").show()
	pass

func _comprar_patatas():
	var text = "Patatas"
	var patatas_label = get_node("LabelPatatas")
	var label_cantidad_patatas = get_node("CantidadPatatas")
	var total_pagar = int(get_node("TotalPagarLabel/TotalPagar").get_text())
	var precio_patatas = int(get_node("Precio5/Patatas").get_text())
	patatas_label.set_text(text)
	cantidad_patatas += 1
	label_cantidad_patatas.set_text(str(cantidad_patatas))
	total_pagar += precio_patatas
	get_node("TotalPagarLabel/TotalPagar").set_text(str(total_pagar))
	get_node("MenosPatatas").show()
	pass
	
func _comprar_huevos():
	var text = "Huevos"
	var huevos_label = get_node("LabelHuevo")
	var label_cantidad_huevos = get_node("CantidadHuevo")
	var total_pagar = int(get_node("TotalPagarLabel/TotalPagar").get_text())
	var precio_huevos = int(get_node("Precio6/Huevo").get_text())
	huevos_label.set_text(text)
	cantidad_huevos += 1
	label_cantidad_huevos.set_text(str(cantidad_huevos))
	total_pagar += precio_huevos
	get_node("TotalPagarLabel/TotalPagar").set_text(str(total_pagar))
	get_node("MenosHuevos").show()
	pass
	
func _comprar_pan():
	var text = "Pan"
	var pan_label = get_node("LabelPan")
	var label_cantidad_pan = get_node("CantidadPan")
	var total_pagar = int(get_node("TotalPagarLabel/TotalPagar").get_text())
	var precio_pan = int(get_node("Precio7/Pan").get_text())
	pan_label.set_text(text)
	cantidad_pan += 1
	label_cantidad_pan.set_text(str(cantidad_pan))
	total_pagar += precio_pan
	get_node("TotalPagarLabel/TotalPagar").set_text(str(total_pagar))
	get_node("MenosPan").show()
	pass

func _comprar_queso():
	var text = "Queso"
	var queso_label = get_node("LabelQueso")
	var label_cantidad_queso = get_node("CantidadQueso")
	var total_pagar = int(get_node("TotalPagarLabel/TotalPagar").get_text())
	var precio_queso = int(get_node("Precio8/Queso").get_text())
	queso_label.set_text(text)
	cantidad_queso += 1
	label_cantidad_queso.set_text(str(cantidad_queso))
	total_pagar += precio_queso
	get_node("TotalPagarLabel/TotalPagar").set_text(str(total_pagar))
	get_node("MenosQueso").show()
	pass

func _menos_vino():
	var vino_label = get_node("LabelVino")
	var label_cantidad_vino = get_node("CantidadVino")
	var total_pagar = int(get_node("TotalPagarLabel/TotalPagar").get_text())
	var precio_vino = int(get_node("Precio/Vino").get_text())
	cantidad_vino -= 1
	label_cantidad_vino.set_text(str(cantidad_vino))
	total_pagar -= precio_vino
	get_node("TotalPagarLabel/TotalPagar").set_text(str(total_pagar))
	if cantidad_vino < 1:
		vino_label.set_text("")
		label_cantidad_vino.set_text("")
		cantidad_vino = 0
		get_node("MenosVino").hide()
		get_parent().get_node("LibroPedidos/LimiteSuperado/LimiteVinoSuperado").hide()
	pass

func _menos_cerveza():
	var cerveza_label = get_node("LabelCerveza")
	var label_cantidad_cerveza = get_node("CantidadCerveza")
	var total_pagar = int(get_node("TotalPagarLabel/TotalPagar").get_text())
	var precio_cerveza = int(get_node("Precio1/Cerveza").get_text())
	cantidad_cerveza -= 1
	label_cantidad_cerveza.set_text(str(cantidad_cerveza))
	total_pagar -= precio_cerveza
	get_node("TotalPagarLabel/TotalPagar").set_text(str(total_pagar))
	if cantidad_cerveza < 1:
		cerveza_label.set_text("")
		label_cantidad_cerveza.set_text("")
		cantidad_cerveza = 0
		get_node("MenosCerveza").hide()
		get_parent().get_node("LibroPedidos/LimiteSuperado/LimiteCervezaSuperado").hide()
	pass

func _menos_carne():
	var carne_label = get_node("LabelCarne")
	var label_cantidad_carne = get_node("CantidadCarne")
	var total_pagar = int(get_node("TotalPagarLabel/TotalPagar").get_text())
	var precio_carne = int(get_node("Precio2/Carne").get_text())
	cantidad_carne -= 1
	label_cantidad_carne.set_text(str(cantidad_carne))
	total_pagar -= precio_carne
	get_node("TotalPagarLabel/TotalPagar").set_text(str(total_pagar))
	if cantidad_carne < 1:
		carne_label.set_text("")
		label_cantidad_carne.set_text("")
		cantidad_carne = 0
		get_node("MenosCarne").hide()
		get_parent().get_node("LibroPedidos/LimiteSuperado/LimiteCarneSuperado").hide()
	pass

func _menos_pescado():
	var pescado_label = get_node("LabelPescado")
	var label_cantidad_pescado = get_node("CantidadPescado")
	var total_pagar = int(get_node("TotalPagarLabel/TotalPagar").get_text())
	var precio_pescado = int(get_node("Precio3/Pescado").get_text())
	cantidad_pescado -= 1
	label_cantidad_pescado.set_text(str(cantidad_pescado))
	total_pagar -= precio_pescado
	get_node("TotalPagarLabel/TotalPagar").set_text(str(total_pagar))
	if cantidad_pescado < 1:
		pescado_label.set_text("")
		label_cantidad_pescado.set_text("")
		cantidad_pescado = 0
		get_node("MenosPescado").hide()
		get_parent().get_node("LibroPedidos/LimiteSuperado/LimitePescadoSuperado").hide()
	pass
	
func _menos_verdura():
	var verdura_label = get_node("LabelVerduras")
	var label_cantidad_verdura = get_node("CantidadVerduras")
	var total_pagar = int(get_node("TotalPagarLabel/TotalPagar").get_text())
	var precio_verdura = int(get_node("Precio4/Verduras").get_text())
	cantidad_verduras -= 1
	label_cantidad_verdura.set_text(str(cantidad_verduras))
	total_pagar -= precio_verdura
	get_node("TotalPagarLabel/TotalPagar").set_text(str(total_pagar))
	if cantidad_verduras < 1:
		verdura_label.set_text("")
		label_cantidad_verdura.set_text("")
		cantidad_verduras = 0
		get_node("MenosVerdura").hide()
		get_parent().get_node("LibroPedidos/LimiteSuperado/LimiteVerdurasSuperado").hide()
	pass

func _menos_patatas():
	var patatas_label = get_node("LabelPatatas")
	var label_cantidad_patatas = get_node("CantidadPatatas")
	var total_pagar = int(get_node("TotalPagarLabel/TotalPagar").get_text())
	var precio_patatas = int(get_node("Precio5/Patatas").get_text())
	cantidad_patatas -= 1
	label_cantidad_patatas.set_text(str(cantidad_patatas))
	total_pagar -= precio_patatas
	get_node("TotalPagarLabel/TotalPagar").set_text(str(total_pagar))
	if cantidad_patatas < 1:
		patatas_label.set_text("")
		label_cantidad_patatas.set_text("")
		cantidad_patatas = 0
		get_node("MenosPatatas").hide()
		get_parent().get_node("LibroPedidos/LimiteSuperado/LimitePatatasSuperado").hide()
	pass

func _menos_huevos():
	var huevos_label = get_node("LabelHuevo")
	var label_cantidad_huevos = get_node("CantidadHuevo")
	var total_pagar = int(get_node("TotalPagarLabel/TotalPagar").get_text())
	var precio_huevos = int(get_node("Precio6/Huevo").get_text())
	cantidad_huevos -= 1
	label_cantidad_huevos.set_text(str(cantidad_huevos))
	total_pagar -= precio_huevos
	get_node("TotalPagarLabel/TotalPagar").set_text(str(total_pagar))
	if cantidad_huevos < 1:
		huevos_label.set_text("")
		label_cantidad_huevos.set_text("")
		cantidad_huevos = 0
		get_node("MenosHuevos").hide()
		get_parent().get_node("LibroPedidos/LimiteSuperado/LimiteHuevosSuperado").hide()
	pass

func _menos_pan():
	var pan_label = get_node("LabelPan")
	var label_cantidad_pan = get_node("CantidadPan")
	var total_pagar = int(get_node("TotalPagarLabel/TotalPagar").get_text())
	var precio_pan = int(get_node("Precio7/Pan").get_text())
	cantidad_pan -= 1
	label_cantidad_pan.set_text(str(cantidad_pan))
	total_pagar -= precio_pan
	get_node("TotalPagarLabel/TotalPagar").set_text(str(total_pagar))
	if cantidad_pan < 1:
		pan_label.set_text("")
		label_cantidad_pan.set_text("")
		cantidad_pan = 0
		get_node("MenosPan").hide()
		get_parent().get_node("LibroPedidos/LimiteSuperado/LimitePanSuperado").hide()
	pass

func _menos_queso():
	var queso_label = get_node("LabelQueso")
	var label_cantidad_queso = get_node("CantidadQueso")
	var total_pagar = int(get_node("TotalPagarLabel/TotalPagar").get_text())
	var precio_queso = int(get_node("Precio8/Queso").get_text())
	cantidad_queso -= 1
	label_cantidad_queso.set_text(str(cantidad_queso))
	total_pagar -= precio_queso
	get_node("TotalPagarLabel/TotalPagar").set_text(str(total_pagar))
	if cantidad_queso < 1:
		queso_label.set_text("")
		label_cantidad_queso.set_text("")
		cantidad_queso = 0
		get_node("MenosQueso").hide()
		get_parent().get_node("LibroPedidos/LimiteSuperado/LimiteQuesoSuperado").hide()
	pass
	
	