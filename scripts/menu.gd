extends Node2D

func _ready():
	pass

func _on_start_pressed():
	get_tree().change_scene_to_file("res://scenes/game.tscn")
	
func _on_settings_pressed():
	get_tree().change_scene_to_file("res://scenes/settings.tscn")

func _process(delta):
	pass
