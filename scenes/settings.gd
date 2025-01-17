#extends Control
#
#@export var volume_slider: HSlider
#@export var resolution_dropdown: OptionButton
#@export var settings_file: String = "res://resources/config_files/settings.cfg"  # Ścieżka do pliku ustawień
#
#var settings = { "volume": 50, "resolution": "1920x1080" }  # Domyślne ustawienia
#
#func _ready():
	#load_settings()
	#update_ui()
#
#func load_settings():
	#if FileAccess.file_exists(settings_file):
		#var file = FileAccess.open(settings_file, FileAccess.READ)
		#settings = file.store_string().to_utf8().parse_json()
		#file.close()
#
#func save_settings():
	#var file = FileAccess.open(settings_file, FileAccess.WRITE)
	#file.store_string(JSON.stringify(settings, "\t"))  # Zapisujemy jako JSON
	#file.close()
#
#func update_ui():
	#volume_slider.value = settings["volume"]
	#for i in range(resolution_dropdown.get_item_count()):
		#if resolution_dropdown.get_item_text(i) == settings["resolution"]:
			#resolution_dropdown.select(i)
			#break
#func _on_historia_pressed():
	#get_tree().change_scene_to_file("res://scenes/ostatnie_gry.tscn")
#func _on_back_pressed():
	#get_tree().change_scene_to_file("res://scenes/menu.tscn")
#
#
#func _on_savesettings_pressed():
	#settings["volume"] = volume_slider.value
	#settings["resolution"] = resolution_dropdown.get_item_text(resolution_dropdown.selected)
#
	## Zapisz ustawienia
	#save_settings()
	#get_tree().change_scene("res://scenes/MainMenu.tscn")  # Powrót do menu głównego
