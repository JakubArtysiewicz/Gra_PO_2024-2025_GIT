extends Control

var config_file = ConfigFile.new()

func _ready():
	print(load_list_from_config())
	#pass

func _process(delta):
	pass 
	
func load_list_from_config() -> Array:
	var err = config_file.load("res://resources/config_files/config_files.cfg")
	if err != OK:
		print("Błąd ładowania pliku:", err)
		return []
	return config_file.get_value("historia", "lista", [])	

#func display_strings():
	#for text in strings_to_display:
		#var label = Label.new()
		#label.text = text
		#container.add_child(label) 
