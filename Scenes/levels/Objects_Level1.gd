# Objects from Level 1
extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$Console/ConsoleInteractableArea2D.consoleInteraction.connect($Door/DoorInteractableArea2D._on_console_interactable_area_2d_console_interaction)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
