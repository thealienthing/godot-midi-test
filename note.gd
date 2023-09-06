extends Node2D

class_name Note

var text

func _init(_text):
	text = _text

# Called when the node enters the scene tree for the first time.
func _ready():
	var sprite = Sprite2D.new()
	var texture = load("res://icon.svg")
	sprite.texture = texture
	add_child(sprite)
	var label = Label.new()
	label.text = text
	label.set_position(Vector2(50, 0))
	add_child(label)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
#	position.x += 1
	position.y += 2
	modulate.a -= 0.005
	
	if modulate.a <= 0.0:
		queue_free()
