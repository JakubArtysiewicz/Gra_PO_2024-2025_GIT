extends Node2D

func _ready():
	var volume = load_volume()
	apply_volume(volume)
	
var config = ConfigFile.new()

func _on_start_pressed():
	get_tree().change_scene_to_file("res://scenes/game.tscn")
	
func _on_settings_pressed():
	get_tree().change_scene_to_file("res://scenes/settings.tscn")

func _process(delta):
	pass
	
func load_volume():
	if config.load("res://resources/config_files/config_files.cfg") == OK:
		return config.get_value("audio", "volume", 0)
	return 0.3
func apply_volume(value):
	var db_value = linear_to_db(value)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), db_value)
