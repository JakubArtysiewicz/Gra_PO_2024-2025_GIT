extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	#var scene = load("res://scenes/game.tscn")
	#get_tree().change_scene_to("res://scenes/game.tscn")
	pass # Replace with function body.

func _on_start_pressed():
	#var scene = load("res://scenes/game.tscn")
	get_tree().change_scene("res://scenes/game.tscn")
	#get_tree().change_scene("res://scenes/game.tscn")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass