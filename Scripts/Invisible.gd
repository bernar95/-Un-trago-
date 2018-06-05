extends Node

func save():
	var save_dict = {
		visible=is_visible()
	}
	return save_dict