extends Node

var last_visited_scene = ""

# Function to update the last visited scene
func update_last_scene(scene_name):
	last_visited_scene = scene_name
	print("Last visited scene:", scene_name)
