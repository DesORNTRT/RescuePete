extends Control

func _on_quit_bg_pressed():
	get_tree().quit()

func _on_restart_b_pressed():
	Global.restart_game()
