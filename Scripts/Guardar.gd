extends Node

const SAVE_PATH = "res://save.json"
var settings = {}

func guardar_partida():
	var save_dict = {}
	var nodes_to_save = get_tree().get_nodes_in_group("Persist")
	for node in nodes_to_save:
		save_dict[node.get_path()] = node.save()
	
	var save_file = File.new()
	save_file.open(SAVE_PATH, File.WRITE)
	
	save_file.store_line(save_dict.to_json())
	save_file.close()
	pass

func cargar_partida():
	var save_file = File.new()
	if not save_file.file_exists(SAVE_PATH):
		return #¡Error! No existe ningún archivo guardado.
	
	var data = {}
	save_file.open(SAVE_PATH, File.READ)
	data.parse_json(save_file.get_as_text())
	var keys = data.keys()
	for node_path in keys:
		var node = get_node(node_path)
		for attribute in data[node_path]:
			if attribute == "experiencia":
				node.set_value(data[node_path]["experiencia"])
			elif attribute == "visible":
				if data[node_path]["visible"] == true:
					node.show()
				else:
					node.hide()
			elif attribute == "dias_abierto":
				node.diasAbierto = data[node_path]["dias_abierto"]
				get_node("Dia").set_text("Día" + " " + str(node.diasAbierto))
			elif attribute == "_servir_comida":
				node.servir_comida = data[node_path]["_servir_comida"]
			elif attribute == "_reputacion":
				node.reputacion = data[node_path]["_reputacion"]
			elif attribute == "experiencia_actual":
				node.experienciaActual = data[node_path]["experiencia_actual"]
			elif attribute == "experiencia_objetivo":
				node.experienciaObjetivo = data[node_path]["experiencia_objetivo"]
			elif attribute == "_cerveceria":
				node.cerveceria = data[node_path]["_cerveceria"]
				if data[node_path]["_cerveceria"] == true:
					get_node("LibroCompras/PermisoCerveceria").show()
			elif attribute == "_aperitivos":
				node.aperitivos = data[node_path]["_aperitivos"]
				if data[node_path]["_aperitivos"] == true:
					get_node("LibroCompras/PermisoAperitivos").show()
			elif attribute == "_comida":
				node.comida = data[node_path]["_comida"]
				if data[node_path]["_comida"] == true:
					get_node("LibroCompras/PermisoComidas").show()
			elif attribute == "texto":
				node.set_text(data[node_path]["texto"])
			elif attribute == "_stock_vino":
				node.stock_vino = data[node_path]["_stock_vino"]
			elif attribute == "_stock_cerveza":
				node.stock_cerveza = data[node_path]["_stock_cerveza"]
			elif attribute == "_stock_carne":
				node.stock_carne = data[node_path]["_stock_carne"]
			elif attribute == "_stock_pescado":
				node.stock_pescado = data[node_path]["_stock_pescado"]
			elif attribute == "_stock_verduras":
				node.stock_verduras = data[node_path]["_stock_verduras"]
			elif attribute == "_stock_patatas":
				node.stock_patatas = data[node_path]["_stock_patatas"]
			elif attribute == "_stock_huevos":
				node.stock_huevos = data[node_path]["_stock_huevos"]
			elif attribute == "_stock_pan":
				node.stock_pan = data[node_path]["_stock_pan"]
			elif attribute == "_stock_queso":
				node.stock_queso = data[node_path]["_stock_queso"]
			elif attribute == "_permiso_cerveceria_comprado":
				node.permiso_cerveceria_comprado = data[node_path]["_permiso_cerveceria_comprado"]
				if data[node_path]["_permiso_cerveceria_comprado"] == true:
					get_node("Container/LibroPedidos/Cerveza").show()
					get_node("LibroPrecios/Cerveza").show()
					get_node("LibroCompras/PermisoCerveceria/Comprado").show()
					get_node("LibroCompras/PermisoCerveceria/Comprar").hide()
					get_parent().get_node("Navegacion").menu["res://Scenes/JarraCerveza.tscn"] = Rect2(Vector2(230, 363), Vector2(20, 20))
			elif attribute == "_permiso_aperitivos_comprado":
				node.permiso_aperitivos_comprado = data[node_path]["_permiso_aperitivos_comprado"]
				if data[node_path]["_permiso_aperitivos_comprado"] == true:
					get_node("Container/LibroPedidos/Pan").show()
					get_node("Container/LibroPedidos/Queso").show()
					get_node("LibroPrecios/Pan").show()
					get_node("LibroPrecios/Queso").show()
					get_node("LibroCompras/PermisoAperitivos/Comprado").show()
					get_node("LibroCompras/PermisoAperitivos/Comprar").hide()
					get_parent().get_node("Navegacion").menu["res://Scenes/pan.tscn"] = Rect2(Vector2(626, 4), Vector2(44, 42))
					get_parent().get_node("Navegacion").menu["res://Scenes/queso.tscn"] = Rect2(Vector2(535, 6), Vector2(35, 35))
			elif attribute == "_permiso_comidas_comprado":
				node.permiso_comidas_comprado = data[node_path]["_permiso_comidas_comprado"]
				if data[node_path]["_permiso_comidas_comprado"] == true:
					get_node("Container/LibroPedidos/Carne").show()
					get_node("Container/LibroPedidos/Pescado").show()
					get_node("Container/LibroPedidos/Verduras").show()
					get_node("Container/LibroPedidos/Patatas").show()
					get_node("Container/LibroPedidos/Huevos").show()
					get_node("LibroPrecios/Carne").show()
					get_node("LibroPrecios/Pescado").show()
					get_node("LibroRecetas/Chuletas").show()
					get_node("LibroRecetas/Bacalao").show()
					get_node("LibroCompras/RecetaQuebrantos").show()
					get_node("LibroCompras/RecetaSopa").show()
					get_node("LibroCompras/RecetaOlla").show()
					get_node("LibroCompras/RecetaEstofado").show()
					get_node("LibroCompras/PermisoComidas/Comprado").show()
					get_node("LibroCompras/PermisoComidas/Comprar").hide()
					get_parent().get_node("Navegacion").menu["res://Scenes/carneCocinada.tscn"] = Rect2(Vector2(50, 610), Vector2(32, 32))
					get_parent().get_node("Navegacion").menu["res://Scenes/pescadoCocinado.tscn"] = Rect2(Vector2(200, 702), Vector2(48, 32))
			elif attribute == "_receta_quebrantos_comprada":
				node.receta_quebrantos_comprada = data[node_path]["_receta_quebrantos_comprada"]
				if data[node_path]["_receta_quebrantos_comprada"] == true:
					get_node("LibroPrecios/Quebrantos").show()
					get_node("LibroRecetas/Quebrantos").show()
					get_node("LibroCompras/RecetaQuebrantos/Comprado").show()
					get_node("LibroCompras/RecetaQuebrantos/Comprar").hide()
					get_node("ComidaDia").desplegable.add_item("Quebrantos")
					get_parent().get_node("Navegacion").menu["res://Scenes/quebrantos.tscn"] = Rect2(Vector2(340, 34), Vector2(32, 32))
			elif attribute == "_receta_sopa_comprada":
				node.receta_sopa_comprada = data[node_path]["_receta_sopa_comprada"]
				if data[node_path]["_receta_sopa_comprada"] == true:
					get_node("LibroPrecios/Sopa").show()
					get_node("LibroRecetas/Sopa").show()
					get_node("LibroCompras/RecetaSopa/Comprado").show()
					get_node("LibroCompras/RecetaSopa/Comprar").hide()
					get_node("ComidaDia").desplegable.add_item("Sopa")
					get_parent().get_node("Navegacion").menu["res://Scenes/sopa.tscn"] = Rect2(Vector2(70, 68), Vector2(32, 32))
			elif attribute == "_receta_olla_comprada":
				node.receta_olla_comprada = data[node_path]["_receta_olla_comprada"]
				if data[node_path]["_receta_olla_comprada"] == true:
					get_node("LibroPrecios/Olla").show()
					get_node("LibroRecetas/Olla").show()
					get_node("LibroCompras/RecetaOlla/Comprado").show()
					get_node("LibroCompras/RecetaOlla/Comprar").hide()
					get_node("ComidaDia").desplegable.add_item("Olla podrida")
					get_parent().get_node("Navegacion").menu["res://Scenes/olla.tscn"] = Rect2(Vector2(273, 238), Vector2(32, 32))
			elif attribute == "_receta_estofado_comprada":
				node.receta_estofado_comprada = data[node_path]["_receta_estofado_comprada"]
				if data[node_path]["_receta_estofado_comprada"] == true:
					get_node("LibroPrecios/Estofado").show()
					get_node("LibroRecetas/Estofado").show()
					get_node("LibroCompras/RecetaEstofado/Comprado").show()
					get_node("LibroCompras/RecetaEstofado/Comprar").hide()
					get_node("ComidaDia").desplegable.add_item("Estofado")
					get_parent().get_node("Hud/ComidaDia").desplegable.add_item("Estofado")