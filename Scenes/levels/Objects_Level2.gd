# Objects from Level 2
extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$Console_Door1_Left/ConsoleInteractableArea2D.consoleInteraction.connect($Door1/DoorInteractableArea2D._on_console_interactable_area_2d_console_interaction)
	$Console_Door1_Right/ConsoleInteractableArea2D.consoleInteraction.connect($Door1/DoorInteractableArea2D._on_console_interactable_area_2d_console_interaction)
	
	$Console_Door2_Left/ConsoleInteractableArea2D.consoleInteraction.connect($Door2/DoorInteractableArea2D._on_console_interactable_area_2d_console_interaction)
	$Console_Door2_Right/ConsoleInteractableArea2D.consoleInteraction.connect($Door2/DoorInteractableArea2D._on_console_interactable_area_2d_console_interaction)
	
	$Console_Door3_Left/ConsoleInteractableArea2D.consoleInteraction.connect($Door3/DoorInteractableArea2D._on_console_interactable_area_2d_console_interaction)
	$Console_Door3_Right/ConsoleInteractableArea2D.consoleInteraction.connect($Door3/DoorInteractableArea2D._on_console_interactable_area_2d_console_interaction)
	
	$Console_Bridge/ConsoleInteractableArea2D.consoleInteraction.connect($Bridge._on_console_interactable_area_2d_console_interaction)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
