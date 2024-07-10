extends Node

var max_lives = 5
var lives = max_lives
var hud
var Is_game_over = false
var game_over_scene = "res://Scenes/menu/GameOver.tscn"
var current_scene = ""

func lose_life(amount : int):
	#lives -= 1
	lives = lives-amount
	hud.load_hearts()
	if lives <= 0:
		#go to the game over scene
		get_tree().change_scene_to_file("res://Scenes/menu/GameOver.tscn") 
	
func game_over(scene_name):
	Is_game_over = true
	game_over_scene = scene_name
	print("Game Over in scene: ", scene_name)

func restart_game():
	if game_over:
		get_tree().change_scene_to_file(game_over_scene)
		Is_game_over = false
		game_over_scene = ""
		
