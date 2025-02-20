extends Control

@onready var volume_slider = $volume_slider

func _ready():
	var volume = load_volume()
	volume_slider.value = volume
	apply_volume(volume)
	
var config = ConfigFile.new()

func _process(delta):
	pass
	
func _on_historia_pressed():
	get_tree().change_scene_to_file("res://scenes/ostatnie_gry.tscn")
func _on_back_pressed():
	get_tree().change_scene_to_file("res://scenes/menu.tscn")

func _on_fullscreen_pressed():
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_MAXIMIZED)

func _on_volume_slider_value_changed(value):
	apply_volume(value)
	save_volume(value)

func apply_volume(value):
	var db_value = linear_to_db(value)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), db_value)

func save_volume(value):
	config.set_value("audio", "volume", value)
	config.save("res://resources/config_files/config_files.cfg")

func load_volume():
	if config.load("res://resources/config_files/config_files.cfg") == OK:
		return config.get_value("audio", "volume", 0)
	return 0.3
