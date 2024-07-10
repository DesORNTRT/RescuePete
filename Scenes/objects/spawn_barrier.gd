extends StaticBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$Sprite2D.visible = true
	$CollisionShape2D.disabled = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func deactivate():
	$Sprite2D.visible = false
	# Has to be disabled with set_deferred so that the Physics Frame is finished before this is changed.
	$CollisionShape2D.set_deferred("disabled", true)


func _on_area_spawn_enemy_body_entered(body):
	if body.name == "Player":
		print(body.name+" entered")
		deactivate()
