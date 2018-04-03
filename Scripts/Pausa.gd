extends Panel

func _ready():
	var reanudar = get_node("Reanudar")
	
	if reanudar:
		reanudar.connect("pressed", self, "_reanudar")
	
	pass

func _reanudar():
	get_tree().set_pause(false)
	hide()
