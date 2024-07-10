extends Label

@onready var textLabel = $"."
var creditText = "Rescue Pete Videogame made in 2024 by Dana da Costa Dominguez, Daniel Neyers and Tim Stenger. \n\n" \
	+ "Credits: \n" \
	+ "Pete and John made by CraftPix (https://craftpix.net/freebies/free-3-cyberpunk-characters-pixel-art)\n" \
	+ "Enemy made by CraftPix (https://craftpix.net/freebies/free-sci-fi-antagonists-pixel-character-pack/)\n" \
	+ "UI Theme made by Azagaya (https://itch.io/queue/c/1473270/themes-for-godot-games?game_id=958881)\n" \
	+ "Tile set and objects made by Jestan (https://jestan.itch.io/space-station-ada)\n" \
	+ "Heart Sprites made by Temok (https://temok.itch.io/heart-container-animated-in-pixel-art) \n\n"
	
	
# Called when the node enters the scene tree for the first time.
func _ready():
	textLabel.text = creditText
	#scroll_text(creditText)


func scroll_text(input_text : String):
	#print_debug(input_text)
	visible_characters = 0
	text = input_text
	
	for i in text.length():
		visible_characters += 1
		await get_tree().create_timer(0.0005).timeout
