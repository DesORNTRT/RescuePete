extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
@onready var animated_sprite_2d = $AnimatedSprite2D

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

enum State {IDLE}
var current_state : State

func _ready():
	current_state = State.IDLE

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	move_and_slide()
	player_animations()
	
func player_idle(delta : float):
	if is_on_floor():
		current_state = State.IDLE

# Player Animations
func player_animations():
	if current_state == State.IDLE:
		animated_sprite_2d.play("idle")


func _on_interaction_area_2d_body_entered(body):
	if body.name == "Player":
		get_tree().change_scene_to_file("res://Scenes/menu/Win.tscn")
