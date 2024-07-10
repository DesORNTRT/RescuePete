extends Control

func _on_resume_b_pressed():
	get_tree().paused = false
	queue_free()  # Remove the pause menu from the scene

func _on_quit_b_pressed():
	get_tree().quit()
