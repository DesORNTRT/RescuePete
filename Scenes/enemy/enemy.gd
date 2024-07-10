extends CharacterBody2D

var speed= 35
var player_chase=false
var player = null
var health = 100
var player_inattack_zone = false
var can_take_damage=true
signal enemy_defeated
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")



func _physics_process(delta):
	
	if player_chase:
		position+= (player.position - position)/speed
		$AnimatedSprite2D.play("Walking")
		if(player.position.x - position.x) < 0:
			$AnimatedSprite2D.flip_h = true 
		else:
			$AnimatedSprite2D.flip_h = false
	else:
		$AnimatedSprite2D.play("Idle")
		
	
	enemy_falling(delta)
	move_and_slide()

# Falling State, have the Enemy be affected by Gravity
func enemy_falling(delta : float):
	if not is_on_floor():
		velocity.y += gravity * delta


func _on_detection_area_body_entered(body):
	player = body
	player_chase = true


func _on_detection_area_body_exited(body):
	player = null
	player_chase = false

#exists so the player recognizes an enemy that is within attack range
func enemy():
	pass


func _on_enemy_hitbox_body_entered(body):
	if body.has_method("player"):
		print("Player entered attack zone")
		player.inattack_zone=true


func _on_enemy_hitbox_body_exited(body):
	if body.has_method("player"):
		print("Player exited attack zone")
		player.inattack_zone=false
		

	
	


func _on_take_damage_cooldown_timeout():
	can_take_damage=true

#function is called when the enemy is defeated to give signal to the level scene
func _on_enemy_defeated():
	emit_signal("enemy_defeated")
	queue_free()

func _on_enemy_hitbox_area_entered(area):
	if area.is_in_group("A"):
		health=health-50
		$take_damage_cooldown.start()
		can_take_damage=false
		print("enemy health = ", health)
		if health<=0:
			_on_enemy_defeated()


func _on_child_exiting_tree(node):
	print("!")
