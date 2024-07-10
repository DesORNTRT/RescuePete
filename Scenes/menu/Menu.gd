extends Control

func _on_b_play_pressed():
	#get_tree().change_scene_to_file("res://Scenes/levels/level_1.tscn")
	get_tree().change_scene_to_file("res://Scenes/menu/Intro.tscn")

func _on_b_exit_pressed():
	get_tree().quit()

#last stable version to make sure this is clear


func _on_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/menu/Credits.tscn")
