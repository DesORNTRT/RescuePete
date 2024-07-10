extends Interactable

signal consoleInteraction

func interact(user : Node2D):
	print_debug("Interacted with Console")
	#emit_signal("interactionWithConsole")
	consoleInteraction.emit()
