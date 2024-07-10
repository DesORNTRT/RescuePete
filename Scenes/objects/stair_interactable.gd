extends Interactable

@export var teleportDestination : Node2D
@onready var teleportPosition = teleportDestination.position-Vector2(0,-27)
@onready var camera_2d = $"../../Camera2D"


func interact(user : Node2D):
	# Hide the Player and disable Interaction
	user.visible = false
	user.get_node("InteractionArea2D/CollisionShape2D").disabled = true
	user.set_physics_process(false)
	# Transition camera to exit-level of the stairway
	camera_transition(camera_2d,"position",teleportPosition,1.0)
	# Wait for 1 second before continuing
	await get_tree().create_timer(1.0).timeout
	user.position = teleportPosition
	await get_tree().create_timer(0.4).timeout
	# Make the Player reappear and enable Interaction
	user.visible = true
	user.get_node("InteractionArea2D/CollisionShape2D").disabled = false
	user.set_physics_process(true)

# Function moves Camera2D linearly from current position to new position.
# Makes cameratransition between floors more smoothly.
func camera_transition(node, property, end_value, duration):
	var tween = create_tween()
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_LINEAR)
	tween.tween_property(node, property, end_value, duration)
