extends Node

var player_current_attack = false

# Called when the node enters the scene tree for the first time.
func _ready():
	# Hintergrundfarbe der Spielwelt, schwarz
	RenderingServer.set_default_clear_color(Color(0.00,0.00,0.00,1.00))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
