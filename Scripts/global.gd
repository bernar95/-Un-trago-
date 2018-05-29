extends Node
#Este script se utiliza para guardar variables globales, como
#el plato del día
var plato_hoy
var labelMomento
var mano_derecha = Vector2(8.841199, 5.105545)
var mano_izquierda= Vector2(-8.841199, 5.105545)

var spriteJarra = preload("res://Scenes/Jarra.tscn")
var jarra = spriteJarra.instance()
var jarra2 = spriteJarra.instance()
var spriteCerveza = preload("res://Scenes/JarraCerveza.tscn")
var cerveza = spriteCerveza.instance()
var cerveza2 = spriteCerveza.instance()
var spriteVino = preload("res://Scenes/JarraVino.tscn")
var vino = spriteVino.instance()
var vino2 = spriteVino.instance()
var spriteCarne = preload("res://Scenes/carne.tscn")
var carne = spriteCarne.instance()
var carne2 = spriteCarne.instance()
var carne3 = spriteCarne.instance()
var spritePescado = preload("res://Scenes/pescado.tscn")
var pescado = spritePescado.instance()
var pescado2 = spritePescado.instance()
var pescado3 = spritePescado.instance()
var spriteVerduras = preload("res://Scenes/verduras.tscn")
var verdura = spriteVerduras.instance()
var verdura2 = spriteVerduras.instance()
var verdura3 = spriteVerduras.instance()
var spritePatatas = preload("res://Scenes/patatas.tscn")
var patata = spritePatatas.instance()
var patata2 = spritePatatas.instance()
var patata3 = spritePatatas.instance()
var spritePan = preload("res://Scenes/pan.tscn")
var pan = spritePan.instance()
var pan2 = spritePan.instance()
var pan3 = spritePan.instance()
var spriteQueso = preload("res://Scenes/queso.tscn")
var queso = spriteQueso.instance()
var queso2 = spriteQueso.instance()
var queso3 = spriteQueso.instance()
var spriteHuevos = preload("res://Scenes/huevos.tscn")
var huevo = spriteHuevos.instance()
var huevo2 = spriteHuevos.instance()
var huevo3 = spriteHuevos.instance()
var spriteCarneCocinada = preload("res://Scenes/carneCocinada.tscn")
var spritePescadoCocinado = preload("res://Scenes/pescadoCocinado.tscn")
var spriteQuebrantos = preload("res://Scenes/quebrantos.tscn")
var spriteOlla = preload("res://Scenes/olla.tscn")
var spriteSopa = preload("res://Scenes/sopa.tscn")
var spriteEstofado = preload("res://Scenes/estofado.tscn")

func _ready():
	plato_hoy = ""
	labelMomento = ""
	jarra.set_pos(mano_derecha)
	jarra2.set_pos(mano_izquierda)
	cerveza.set_pos(mano_derecha)
	cerveza2.set_pos(mano_izquierda)
	vino.set_pos(mano_derecha)
	vino2.set_pos(mano_izquierda)
	carne.set_pos(mano_derecha)
	carne2.set_pos(mano_izquierda)
	pescado.set_pos(mano_derecha)
	pescado2.set_pos(mano_izquierda)
	verdura.set_pos(mano_derecha)
	verdura2.set_pos(mano_izquierda)
	patata.set_pos(mano_derecha)
	patata2.set_pos(mano_izquierda)
	pan.set_pos(mano_derecha)
	pan2.set_pos(mano_izquierda)
	queso.set_pos(mano_derecha)
	queso2.set_pos(mano_izquierda)
	huevo.set_pos(mano_derecha)
	huevo2.set_pos(mano_izquierda)
	carne3.set_pos(Vector2(290, 42))
	pescado3.set_pos(Vector2(640, 42))
	verdura3.set_pos(Vector2(704, 42))
	patata3.set_pos(Vector2(736, 42))
	pan3.set_pos(Vector2(512, 26))
	queso3.set_pos(Vector2(672, 42))
	huevo3.set_pos(Vector2(544, 26))
	pass

func instanciar_jarras(recipiente):
	if recipiente == "Jarra":
		jarra = spriteJarra.instance()
		jarra.set_pos(mano_derecha)
	elif recipiente == "Jarra2":
		jarra2 = spriteJarra.instance()
		jarra2.set_pos(mano_izquierda)
	elif recipiente == "JarraVino":
		vino = spriteVino.instance()
		vino.set_pos(mano_derecha)
	elif recipiente == "JarraVino2":
		vino2 = spriteVino.instance()
		vino2.set_pos(mano_izquierda)
	elif recipiente == "JarraCerveza":
		cerveza = spriteCerveza.instance()
		cerveza.set_pos(mano_derecha)
	elif recipiente == "JarraCerveza2":
		cerveza2 = spriteCerveza.instance()
		cerveza2.set_pos(mano_izquierda)

func instanciar_ingredientes(ingrediente):
	if ingrediente == carne:
		carne = spriteCarne.instance()
		carne.set_pos(mano_derecha)
	elif ingrediente == carne2:
		carne2 = spriteCarne.instance()
		carne2.set_pos(mano_izquierda)
	elif ingrediente == pescado:
		pescado = spritePescado.instance()
		pescado.set_pos(mano_derecha)
	elif ingrediente == pescado2:
		pescado2 = spritePescado.instance()
		pescado2.set_pos(mano_izquierda)
	elif ingrediente == verdura:
		verdura = spriteVerduras.instance()
		verdura.set_pos(mano_derecha)
	elif ingrediente == verdura2:
		verdura2 = spriteVerduras.instance()
		verdura2.set_pos(mano_izquierda)
	elif ingrediente == patata:
		patata = spritePatatas.instance()
		patata.set_pos(mano_derecha)
	elif ingrediente == patata2:
		patata2 = spritePatatas.instance()
		patata2.set_pos(mano_izquierda)
	elif ingrediente == huevo:
		huevo = spriteHuevos.instance()
		huevo.set_pos(mano_derecha)
	elif ingrediente == huevo2:
		huevo2 = spriteHuevos.instance()
		huevo2.set_pos(mano_izquierda)
	elif ingrediente == pan:
		pan = spritePan.instance()
		pan.set_pos(mano_derecha)
	elif ingrediente == pan2:
		pan2 = spritePan.instance()
		pan2.set_pos(mano_izquierda)
	elif ingrediente == queso:
		queso = spriteQueso.instance()
		queso.set_pos(mano_derecha)
	elif ingrediente == queso2:
		queso2 = spriteQueso.instance()
		queso2.set_pos(mano_izquierda)

func instanciar_comida(comida):
	var comidaCocinada
	if comida == "CarneCocinada":
		comidaCocinada = spriteCarneCocinada.instance()
		comidaCocinada.set_pos(mano_derecha)
	elif comida == "CarneCocinada2":
		comidaCocinada = spriteCarneCocinada.instance()
		comidaCocinada.set_pos(mano_izquierda)
	elif comida == "PescadoCocinado":
		comidaCocinada = spritePescadoCocinado.instance()
		comidaCocinada.set_pos(mano_derecha)
	elif comida == "PescadoCocinado2":
		comidaCocinada = spritePescadoCocinado.instance()
		comidaCocinada.set_pos(mano_izquierda)
	elif comida == "Sopa":
		comidaCocinada = spriteSopa.instance()
		comidaCocinada.set_pos(mano_derecha)
	elif comida == "Sopa2":
		comidaCocinada = spriteSopa.instance()
		comidaCocinada.set_pos(mano_izquierda)
	elif comida == "Quebrantos":
		comidaCocinada = spriteQuebrantos.instance()
		comidaCocinada.set_pos(mano_derecha)
	elif comida == "Quebrantos2":
		comidaCocinada = spriteQuebrantos.instance()
		comidaCocinada.set_pos(mano_izquierda)
	elif comida == "Olla":
		comidaCocinada = spriteOlla.instance()
		comidaCocinada.set_pos(mano_derecha)
	elif comida == "Olla2":
		comidaCocinada = spriteOlla.instance()
		comidaCocinada.set_pos(mano_izquierda)
	elif comida == "Estofado":
		comidaCocinada = spriteEstofado.instance()
		comidaCocinada.set_pos(mano_derecha)
	elif comida == "Estofado2":
		comidaCocinada = spriteEstofado.instance()
		comidaCocinada.set_pos(mano_izquierda)
	return comidaCocinada