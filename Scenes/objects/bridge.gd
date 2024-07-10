extends StaticBody2D

# Variable die festlegt, ob die Brücke beim ersten Interagieren öffnet oder schließt
@export var is_activating = false :
	# Wird beim Ausführen des Skripts ausgeführt.
	set(value):
		if(is_activating == value):
			return
		# Wird nur aufgerufen, wenn sich der Wert von is_opening verändert hat.
		is_activating = value
		# Wird immer aufgerufen, wenn der Wert von is_opening verändert wird.
		_update_animations()

@export var animation_player : AnimationPlayer:
	# Wird beim Ausführen des Skripts ausgeführt, wenn der AnimationPlayer geladen wird.
	set(value):
		animation_player = value
		_update_animations()

@export_group("Animation Names")
@export var turning_on_animation = "Turning_On"
@export var turning_off_animation = "Turning_Off"
@export var enabled_animation = "Enabled"
@export var disabled_animation = "Disabled"



func _update_animations():
	if(animation_player != null):
		if(is_activating):
			animation_player.play(turning_on_animation)
			#print_debug("Turning_On_Animation Started")
		else:
			animation_player.play(turning_off_animation)
			
		#animation_player.animation_finished

# Funktion wird aufgerufen wenn Console das Signal "consoleInteraction" sendet
func _on_console_interactable_area_2d_console_interaction():
	#print_debug("Bridge received signal from Console")
	is_activating = not is_activating # toggle door on and off
	#print_debug("Toggle Bridge activation button")


func _on_animation_player_animation_finished(animation_name):
	# Check if the turning_on_animation finished, then play "Enabled" animation.
	if(animation_player != null and animation_name == turning_on_animation):
		animation_player.play(enabled_animation)
