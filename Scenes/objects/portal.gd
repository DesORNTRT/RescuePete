extends StaticBody2D

signal player_entered_teleporter
signal player_exited_teleporter

func _on_area_2d_body_entered(body):
	if body.name == "Player": #player.name
		print_debug("Player entered Teleporter hard")
		player_entered_teleporter.emit(body)



func _on_area_2d_body_exited(body):
	if body.name == "Player": #player.name
		print_debug("Player exited Teleporter hard")
		player_exited_teleporter.emit(body)
