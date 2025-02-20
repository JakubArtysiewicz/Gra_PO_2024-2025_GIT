extends Sprite2D


@onready var tween = $Tween

func _ready():
	pass # Replace with function body.


func move_to(target: Vector2):
	tween.tween_property(self, "position", target, 1.0).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
