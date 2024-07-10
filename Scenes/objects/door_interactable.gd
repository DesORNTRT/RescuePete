extends Interactable

# Variable die festlegt, ob die Tür beim ersten Interagieren öffnet oder schließt
@export var is_opening = false :
	# Wird beim Ausführen des Skripts ausgeführt.
	set(value):
		if(is_opening == value):
			return
		# Wird nur aufgerufen, wenn sich der Wert von is_opening verändert hat.
		is_opening = value
		# Wird immer aufgerufen, wenn der Wert von is_opening verändert wird.
		_update_animations()

@export var animation_player : AnimationPlayer:
	# Wird beim Ausführen des Skripts ausgeführt, wenn der AnimationPlayer geladen wird.
	set(value):
		animation_player = value
		_update_animations()

@export_group("Animation Names")
@export var open_animation = "open_animation"
#@export var idle_animation = "idle" # Wird bei der Türanimation nicht benötigt

@onready var doorInteractable_CollisionShape = $CollisionShape2D

func _ready():
	doorInteractable_CollisionShape.disabled = true
	


# In dieser Funktion wird festgelegt was passiert, wenn Spieler direkt mit der Tür interagiert
func interact(user : Node2D):
	# Auskommentiert, da Türe nur über die Console geöffnet werden soll
	#is_opening = not is_opening # toggle door on and off
	#print_debug("Toggle Open door button")
	pass

func stop_interaction(user : Node2D):
	pass

func _update_animations():
	if(animation_player != null):
		if(is_opening):
			animation_player.play(open_animation)
		else:
			animation_player.play_backwards(open_animation)

# Funktion wird aufgerufen wenn Console das Signal "consoleInteraction" sendet
func _on_console_interactable_area_2d_console_interaction():
	print_debug("Door received signal from Console")
	is_opening = not is_opening # toggle door on and off
	print_debug("Toggle Open door button")
	
func _on_level_2_enemies_in_level_defeated():
	print_debug("all enemies were eliminated, signal received")
	is_opening = not is_opening # toggle door on and off
