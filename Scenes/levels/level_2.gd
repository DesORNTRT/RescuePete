extends Node2D

signal enemies_in_level_defeated
var enemies_defeated = false

# Called when the node enters the scene tree for the first time.
func _ready():
	Global.current_scene = "res://Scenes/levels/level_2.tscn"
	Global.lives = 5
	$WarningPop.hide()
	$WarningPop/WarningPopL.hide()
	
	# Connect signal that enemies are defeated to Door4.
	$".".enemies_in_level_defeated.connect($Objects/Door4/DoorInteractableArea2D._on_level_2_enemies_in_level_defeated)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	# Check each second if all enemies in the level were defeated.
	# If true, send signal that they are defeated.
	await get_tree().create_timer(1.0).timeout
	if (enemies_defeated == false and get_tree().get_nodes_in_group("Enemies").size() == 0):
		print_debug("all enemies defeated, send signal")
		enemies_in_level_defeated.emit()
		enemies_defeated = true


func _on_warning_area_body_entered(body):
	if body.name == "Player":
		$WarningPop.show()
		$WarningPop/WarningPopL.show()

func _on_warning_area_body_exited(body):
	if body.name == "Player":
		$WarningPop.hide()
		$WarningPop/WarningPopL.hide()


func _on_area_2d_body_entered(body):
	if body.name == "Player":
		get_tree().change_scene_to_file("res://Scenes/menu/Win.tscn")

