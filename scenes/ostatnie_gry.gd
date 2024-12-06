extends Control

var config_file = ConfigFile.new()

func _ready():
	print(load_list_from_config())
	wstaw_elementy_do_scroll(load_list_from_config())
	#pass

func _process(delta):
	pass 
	
func _on_back_pressed():
	get_tree().change_scene_to_file("res://scenes/settings.tscn")
	
func load_list_from_config() -> Array:
	var err = config_file.load("res://resources/config_files/config_files.cfg")
	if err != OK:
		print("Błąd ładowania pliku:", err)
		return []
	return config_file.get_value("historia", "lista", [])	

@onready var scroll_container = $ScrollContainer
@onready var vbox_container = $ScrollContainer/VBoxContainer

func wstaw_elementy_do_scroll(lista_elementow):
	for child in vbox_container.get_children():
		child.queue_free()

	for i in range(lista_elementow.size() - 1, -1, -1):
		var element = lista_elementow[i]
		var label = Label.new()
		label.text = str(element)
		vbox_container.add_child(label)

