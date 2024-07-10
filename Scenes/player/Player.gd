extends CharacterBody2D

# Variables and Nodes
var enemy_in_attack_range = false
var enemy_attack_cooldown = true
var health = 100
var player_alive = true
var attack_in_progress = false
signal player_died


#to use the esc button for also closing the pause menu
@export var pause_menu_path: String = "res://Scenes/menu/paused_menu.tscn"
var pause_menu: Control
var isEsc: bool = false

@onready var animated_sprite_2d = $AnimatedSprite2D

@export var speed : int = 300
@export var jump_velocity : int = -300
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

# Test for falldamage
var max_velocity : float = 0.0
# Velocity above which falldamage can be inflicted
@export var falldamage_threshold : float = 400.0
# Determines in which increments of velocity > falldamage_threshold damage will be inflicted
@export var falldamage_velocity_increments : int = 100
# Determines how much damage will be inflicted per falldamage_velocity_increments
@export var falldamage_per_increment : int = 20
var falldamage_inflicted = 0

enum State { IDLE, RUN, JUMP, ATTACK }
var current_state : State

var flipped : bool = false

# Initialization
func _ready():
	current_state = State.IDLE
	var global_scene_tracker = get_node("res://scripts/GlobalSceneTracker.gd") 
	if global_scene_tracker:
		global_scene_tracker.update_last_scene(get_tree().current_scene.name)
	health = 100


# Physics Process
func _physics_process(delta : float):
	if player_alive:
		enemy_attack()
		attack()
		handle_death()
		player_falling(delta)
		player_idle(delta)
		player_run(delta)
		player_jump(delta)
		flip()
		move_and_slide()
		player_animations()

# Falling State
func player_falling(delta : float):
	if not is_on_floor():
		velocity.y += gravity * delta
		if current_state != State.ATTACK:
			current_state = State.JUMP
		max_velocity = velocity.y
	# Calculate damage the player takes when falling
	elif(max_velocity>falldamage_threshold):
		#print_debug("We reached velocity"+str(max_velocity))
		falldamage_inflicted = int(max_velocity-falldamage_threshold)/falldamage_velocity_increments*falldamage_per_increment
		#print_debug("Falldamage "+str(falldamage_inflicted))
		health -= falldamage_inflicted
		Global.lose_life(falldamage_inflicted/20)
		max_velocity=0

# Idle State
func player_idle(delta : float):
	if is_on_floor() and current_state != State.ATTACK:
		current_state = State.IDLE

# Run State
func player_run(delta : float):
	var direction = get_input_movement_direction()
	if direction != 0:
		velocity.x = direction * speed
		if is_on_floor() and current_state != State.ATTACK:
			current_state = State.RUN
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

# Jump State
func player_jump(delta : float):
	if Input.is_action_just_pressed("move_jump") and is_on_floor():
		velocity.y = jump_velocity
		current_state = State.JUMP

# Player Animations
func player_animations():
	if attack_in_progress:
		animated_sprite_2d.play("attack_animation")
	elif current_state == State.IDLE and not attack_in_progress:
		animated_sprite_2d.play("idle_animation")
	elif current_state == State.RUN and not attack_in_progress:
		animated_sprite_2d.play("run_animation")
	elif current_state == State.JUMP and not attack_in_progress:
		animated_sprite_2d.play("jump_animation")

# Get Movement Direction
func get_input_movement_direction():
	return Input.get_action_strength("move_right") - Input.get_action_strength("move_left")

# Flip Character
func flip():
	var direction = get_input_movement_direction()
	if direction < 0 and not flipped:
		flipped = true
		animated_sprite_2d.flip_h = true
	elif direction > 0 and flipped:
		flipped = false
		animated_sprite_2d.flip_h = false

func handle_death():
	if health <= 0:
		player_alive = false
		health = 0
		print("player dead")
		Global.game_over(Global.current_scene)
		queue_free()

# Detect when an enemy enters or exits the hitbox
func _on_player_hitbox_body_entered(body):
	if body.has_method("enemy"):
		enemy_in_attack_range = true

func _on_player_hitbox_body_exited(body):
	if body.has_method("enemy"):
		enemy_in_attack_range = false

# Enemy Attack
func enemy_attack():
	if enemy_in_attack_range and enemy_attack_cooldown:
		health -= 20
		Global.lose_life(1)
		enemy_attack_cooldown = false
		$attack_cooldown.start()
		print(health)

func _on_attack_cooldown_timeout():
	enemy_attack_cooldown = true

# Player Attack
func attack():
	var dir = get_input_movement_direction()
	if Input.is_action_just_pressed("attack"):
		attack_in_progress = true
		current_state = State.ATTACK
		GameManager.player_current_attack = true
		if flipped:
			$AttackArea/AttackHitboxL.disabled=false
		else:
			$AttackArea/AttackHitboxR.disabled=false
		if dir != 0:
			animated_sprite_2d.flip_h = dir < 0
		animated_sprite_2d.play("attack_animation")
		$deal_attack_timer.start()

func _on_deal_attack_timer_timeout():
	$deal_attack_timer.stop()
	GameManager.player_current_attack = false
	attack_in_progress = false
	$AttackArea/AttackHitboxR.disabled=true
	$AttackArea/AttackHitboxL.disabled=true
	if is_on_floor():
		current_state = State.IDLE
	else:
		current_state = State.JUMP

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		if isEsc == false:
			_pause_game()
		else:
			_unpause_game()

func _pause_game():
	if !pause_menu:
		var pause_menu_scene = load(pause_menu_path) as PackedScene
		pause_menu = pause_menu_scene.instantiate()
		add_child(pause_menu)
	get_tree().paused = true
	isEsc = true

func _unpause_game():
	if isEsc:
		get_tree().paused = false
		if pause_menu:
			#pause_menu.queue_free()
			pause_menu = null
		isEsc = false
		#get_tree().change_scene_to("res://Scenes/menu/paused_menu.tscn")

func get_last_visited_scene():
	var global_scene_tracker = get_node("res://scripts/GlobalSceneTracker.gd") # Adjust path as per your project setup
	if global_scene_tracker:
		return global_scene_tracker.last_visited_scene
	else:
		return ""
		
func player():
	pass




func _on_area_2d_body_entered(body):
	if body.name == "Player":
		print("be")
		get_tree().change_scene_to_file("res://Scenes/menu/Win.tscn")
