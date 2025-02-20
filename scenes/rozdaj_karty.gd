extends Sprite2D

var poczatkowa_wartosc_rozmieszczenia_kart_gracza_px = 550
var poczatkowa_wartosc_rozmieszczenia_kart_krupiera_px = 550
var poczatkowa_wartosc_rozmieszczenia_kart_gracza_py = 400
var poczatkowa_wartosc_rozmieszczenia_kart_krupiera_py = 150

@onready var card_scene = preload("res://Card.tscn")
var player_position = Vector2(500, 300)  # Pozycja gracza

func spawn_card():
	var card = card_scene.instantiate()
	add_child(card)
	card.position = Vector2(randf_range(100, 900), -100)  # Startowa pozycja (np. góra ekranu)
	card.move_to_player(player_position)  # Przesuń do gracza


func _ready():
	pass # Replace with function body.
	
@onready var tween = $Tween

func move_to_player(target_position: Vector2):
	tween.tween_property(self, "position", target_position, 0.5).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	await get_tree().create_timer(0.5).timeout  
	queue_free()  

func _process(delta):
	pass
