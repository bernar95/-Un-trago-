extends Node

var tiempo = Timer.new()
var destinos
var menu
var precios
var npcDic
var spriteNpc
var npcIndex = 0
var npcs
var espera

class Destino:
	var ocupado
	var posicion
	var orientacion
	var npc
	
	func _init(ocupado, posicion, orientacion, npc):
		self.ocupado = ocupado
		self.posicion = posicion
		self.orientacion = orientacion
		self.npc = npc
	
	func set_ocupado(arg):
		self.ocupado = arg
	
	func set_npc(arg):
		self.npc = arg
	
	func get_ocupado():
		return self.ocupado
	
	func get_posicion():
		return self.posicion
	
	func get_orientacion():
		return self.orientacion
	
	func get_npc():
		return self.npc

func _ready():
	tiempo.set_one_shot(true)
	self.add_child(tiempo)
#Esta variable es un diccionario que se le va pasando a cada uno de los npcs, y
#que contiene los distintos productos que pueden pedir
	menu = {
	"res://Scenes/JarraVino.tscn": Rect2(Vector2(197, 337), Vector2(20, 20))}
#Esta variable es un diccionario que se le va pasando a cada uno de los npcs, y
#que contiene los precios de los productos
	precios = {
	"res://Scenes/JarraVino.tscn": 2,
	"res://Scenes/JarraCerveza.tscn":3,
	"res://Scenes/pan.tscn":1,
	"res://Scenes/queso.tscn":1,
	"res://Scenes/carneCocinada.tscn":2,
	"res://Scenes/pescadoCocinado.tscn":3,
	"res://Scenes/sopa.tscn":2,
	"res://Scenes/quebrantos.tscn":5,
	"res://Scenes/olla.tscn":4,
	"res://Scenes/estofado.tscn":5}
#Esta variable es un diccionario que contiene las rutas de los sprites de los
#diferentes npcs que se pueden generar
	npcDic = {
	1:"res://Scenes/NPC1.tscn",
	2:"res://Scenes/NPC2.tscn",
	3:"res://Scenes/NPC3.tscn",
	4:"res://Scenes/NPC4.tscn",
	5:"res://Scenes/NPC5.tscn",
	6:"res://Scenes/NPC6.tscn",
	7:"res://Scenes/NPC7.tscn",
	8:"res://Scenes/NPC8.tscn",
	9:"res://Scenes/NPC9.tscn",
	10:"res://Scenes/NPC10.tscn"}
#Esta variable es un diccionario que se le va pasando a cada uno de los npcs, y
#que contiene todos los lugares de la taberna donde pueden ir, con información
#sobre si el lugar está ocupado, su posición, la orientación que deben tomar los
#npcs y, en el caso de que haya algún npc en ese lugar, el npc en concreto.
	destinos = {
	"Barril1":Destino.new(false, Vector2(139.056, 422.390015), 4, null),
	"Barril2":Destino.new(false, Vector2(411.056, 264.390015), 4, null),
	"Barril3":Destino.new(false, Vector2(501.056, 235.389999), 8, null),
	"Barril4":Destino.new(false, Vector2(692.05603, 378.390015), 8, null),
	"Barril5":Destino.new(false, Vector2(523.05603, 490.390015), 4, null),
	"Barril6":Destino.new(false, Vector2(900.05603, 394.390015), 8, null),
	"Barril7":Destino.new(false, Vector2(885.05603, 172.389999), 8, null),
	"Barra1":Destino.new(false, Vector2(279.942993, 172.425995), 12, null),
	"Barra2":Destino.new(false, Vector2(310.942993, 172.425995), 12, null),
	"Barra3":Destino.new(false, Vector2(342.942993, 172.425995), 12, null),
	"Barra4":Destino.new(false, Vector2(373.942993, 172.425995), 12, null),
	"Barra5":Destino.new(false, Vector2(405.942993, 172.425995), 12, null),
	"Barra6":Destino.new(false, Vector2(436.942993, 172.425995), 12, null),
	"Barra7":Destino.new(false, Vector2(468.942993, 172.425995), 12, null),
	"Barra8":Destino.new(false, Vector2(499.942993, 172.425995), 12, null),
	"Barra9":Destino.new(false, Vector2(531.942993, 172.425995), 12, null),
	"Barra10":Destino.new(false, Vector2(562.942993, 172.425995), 12, null),
	"Barra11":Destino.new(false, Vector2(593.942993, 172.425995), 12, null),
	"Barra12":Destino.new(false, Vector2(625.942993, 172.425995), 12, null),
	"Barra13":Destino.new(false, Vector2(657.942993, 172.425995), 12, null),
	"Barra14":Destino.new(false, Vector2(688.942993, 172.425995), 12, null),
	"Barra15":Destino.new(false, Vector2(720.942993, 172.425995), 12, null),
	"Barra16":Destino.new(false, Vector2(752.942993, 172.425995), 12, null),
	"Barra17":Destino.new(false, Vector2(783.942993, 172.425995), 12, null),
	"Barra18":Destino.new(false, Vector2(214.942993, 111.426003), 8, null),
	"Barra19":Destino.new(false, Vector2(214.942993, 68.426003), 8, null),
	"Silla":Destino.new(false, Vector2(784.307983, 306.375), 12, null),
	"Silla1":Destino.new(false, Vector2(816.307983, 306.375), 12, null),
	"Silla2":Destino.new(false, Vector2(864.307983, 306.375), 12, null),
	"Silla3":Destino.new(false, Vector2(896.307983, 306.375), 12, null),
	"Silla4":Destino.new(false, Vector2(894.940002, 224.264008), 0, null),
	"Silla5":Destino.new(false, Vector2(862.940002, 224.264008), 0, null),
	"Silla6":Destino.new(false, Vector2(814.940002, 224.264008), 0, null),
	"Silla7":Destino.new(false, Vector2(782.940002, 224.264008), 0, null),
	"Silla8":Destino.new(false, Vector2(574.940002, 304.264008), 0, null),
	"Silla9":Destino.new(false, Vector2(542.940002, 304.264008), 0, null),
	"Silla10":Destino.new(false, Vector2(366.940002, 320.264008), 0, null),
	"Silla11":Destino.new(false, Vector2(334.940002, 320.264008), 0, null),
	"Silla12":Destino.new(false, Vector2(222.940002, 255.326004), 0, null),
	"Silla13":Destino.new(false, Vector2(191.940002, 255.326004), 0, null),
	"Silla14":Destino.new(false, Vector2(142.940002, 255.326004), 0, null),
	"Silla15":Destino.new(false, Vector2(110.940002, 255.326004), 0, null),
	"Silla16":Destino.new(false, Vector2(127.940002, 97.326103), 0, null),
	"Silla17":Destino.new(false, Vector2(95.940002, 97.035698), 0, null),
	"Silla18":Destino.new(false, Vector2(190.940002, 464.325989), 0, null),
	"Silla19":Destino.new(false, Vector2(222.940002, 464.325989), 0, null),
	"Silla20":Destino.new(false, Vector2(271.940002, 464.325989), 0, null),
	"Silla21":Destino.new(false, Vector2(302.940002, 464.325989), 0, null),
	"Silla22":Destino.new(false, Vector2(670.940002, 448.325989), 0, null),
	"Silla23":Destino.new(false, Vector2(702.940002, 448.325989), 0, null),
	"Silla24":Destino.new(false, Vector2(846.940002, 432.325989), 0, null),
	"Silla25":Destino.new(false, Vector2(878.940002, 432.325989), 0, null),
	"Silla26":Destino.new(false, Vector2(576.307983, 386.375), 12, null),
	"Silla27":Destino.new(false, Vector2(544.307983, 386.375), 12, null),
	"Silla28":Destino.new(false, Vector2(368.308014, 403.375), 12, null),
	"Silla29":Destino.new(false, Vector2(336.308014, 403.375), 12, null),
	"Silla30":Destino.new(false, Vector2(224.307999, 338.375), 12, null),
	"Silla31":Destino.new(false, Vector2(192.307999, 338.375), 12, null),
	"Silla32":Destino.new(false, Vector2(144.307999, 338.375), 12, null),
	"Silla33":Destino.new(false, Vector2(112.307999, 338.375), 12, null),
	"Silla34":Destino.new(false, Vector2(128.307999, 178.375), 12, null),
	"Silla35":Destino.new(false, Vector2(96.307999, 178.375), 12, null),
	"Silla36":Destino.new(false, Vector2(192.307999, 546.375), 12, null),
	"Silla37":Destino.new(false, Vector2(224.307999, 546.375), 12, null),
	"Silla38":Destino.new(false, Vector2(272.308014, 546.375), 12, null),
	"Silla39":Destino.new(false, Vector2(304.308014, 546.375), 12, null),
	"Silla40":Destino.new(false, Vector2(672.307983, 530.375), 12, null),
	"Silla41":Destino.new(false, Vector2(704.307983, 530.375), 12, null),
	"Silla42":Destino.new(false, Vector2(848.307983, 514.375), 12, null),
	"Silla43":Destino.new(false, Vector2(880.307983, 514.375), 12, null)}
	pass
func set_menu(menu_nuevo):
	menu = menu_nuevo
#Esta función es la que se encarga de hacer aparecer a los npcs, tantos como
#deje la variable "npcs". Primero se elige el sprite del npc, después se 
#instancia, se le asignan diferentes propiedades(destinos, menu, precios...)
#y por último, se le añade una unidad al índice "npcIndex" y se establece un
#tiempo de espera hasta que aparezca el siguiente npc. Y así sucesivamente
#hasta que "npcIndex" sea igual que "npcs"
func aparecer_npcs():
	get_parent().get_node("Sonidos/SamplePlayer2D").play("Ambiente", 7)
	randomize()
	var num = randi()%3+1
	for i in range(0, num):
		npc_aleatorio()
		var npc = spriteNpc.instance()
		npc.set_pos(get_node("Navigation2D/Spawn").get_pos())
		get_node("Navigation2D").add_child(npc)
		npc.get_node("NPC").destinos = destinos
		npc.get_node("NPC").menu = menu
		npc.get_node("NPC").navegacion = get_node("Navigation2D")
		npc.get_node("NPC").andar = true
		npc.get_node("NPC").reputacion = get_parent().get_node("Hud/Reputacion")
		npc.get_node("NPC").precios = precios
		npc.get_node("NPC").dinero = get_parent().get_node("Hud/Dinero")
		npc.get_node("NPC").sonidos = get_parent().get_node("Sonidos/SamplePlayer2D")
	npcIndex +=1
	if npcIndex == npcs:
		npcIndex = 0
	else:
		tiempo.set_wait_time(espera)
		tiempo.start()
		yield(tiempo, "timeout")
		aparecer_npcs()
#Esta función es la que se encarga de eegir un sprite de npc aleatorio
func npc_aleatorio():
	randomize()
	var npc = randi()%npcDic.keys().size()+1
	
	if npcDic[npc] == "res://Scenes/NPC1.tscn":
		spriteNpc = preload("res://Scenes/NPC1.tscn")
	elif npcDic[npc] == "res://Scenes/NPC2.tscn":
		spriteNpc = preload("res://Scenes/NPC2.tscn")
	elif npcDic[npc] == "res://Scenes/NPC3.tscn":
		spriteNpc = preload("res://Scenes/NPC3.tscn")
	elif npcDic[npc] == "res://Scenes/NPC4.tscn":
		spriteNpc = preload("res://Scenes/NPC4.tscn")
	elif npcDic[npc] == "res://Scenes/NPC5.tscn":
		spriteNpc = preload("res://Scenes/NPC5.tscn")
	elif npcDic[npc] == "res://Scenes/NPC6.tscn":
		spriteNpc = preload("res://Scenes/NPC6.tscn")
	elif npcDic[npc] == "res://Scenes/NPC7.tscn":
		spriteNpc = preload("res://Scenes/NPC7.tscn")
	elif npcDic[npc] == "res://Scenes/NPC8.tscn":
		spriteNpc = preload("res://Scenes/NPC8.tscn")
	elif npcDic[npc] == "res://Scenes/NPC9.tscn":
		spriteNpc = preload("res://Scenes/NPC9.tscn")
	elif npcDic[npc] == "res://Scenes/NPC10.tscn":
		spriteNpc = preload("res://Scenes/NPC10.tscn")
#Esta función se encarga de asignar el número de npcs(variable "npcs") que 
#irán apareciendo, en función del momento del día y de la reputación de 
#la taberna
func numero_npcs(): 
	var reputacion = int(get_parent().get_node("Hud/Reputacion/Reputacion").get_text())
	var bonus
	if global.labelMomento == "Mañana":
		if reputacion >= 0 and reputacion <16:
			bonus = 4
		elif reputacion >= 16 and reputacion <32:
			bonus = 6
		elif reputacion >= 32 and reputacion <48:
			bonus = 8
		elif reputacion >= 48 and reputacion <64:
			bonus = 10
		elif reputacion >= 64:
			bonus = 12
	elif global.labelMomento == "Tarde":
		if reputacion >= 0 and reputacion <16:
			bonus = 6
		elif reputacion >= 16 and reputacion <32:
			bonus = 8
		elif reputacion >= 32 and reputacion <48:
			bonus = 10
		elif reputacion >= 48 and reputacion <64:
			bonus = 12
		elif reputacion >= 64:
			bonus = 14
	elif global.labelMomento == "Noche":
		if reputacion >= 0 and reputacion <16:
			bonus = 8
		elif reputacion >= 16 and reputacion <32:
			bonus = 10
		elif reputacion >= 32 and reputacion <48:
			bonus = 12
		elif reputacion >= 48 and reputacion <64:
			bonus = 14
		elif reputacion >= 64:
			bonus = 16
	npcs = abs(reputacion/4) + bonus
#Esta función sirve para establecer el tiempo de espera de aparición
#del siguiente npc
func establecer_espera():
	espera = abs(180/npcs)