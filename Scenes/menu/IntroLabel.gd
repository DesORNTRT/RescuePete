extends Label

@onready var textLabel = $"."
var introText = "It is a warm june evening and you and your friend Pete had a lot of fun at the local village festival. " \
	+ "The night has fallen and you walk along an empty road that is illuminated by moonshine. \n" \
	+ "As you pass a pasture, you see a cow that is staring at you. " \
	+ "Just as you turn towards the cow and stare right back into its black eyes, you see a bright light reflecting in its eyes and hide. " \
	+ "You turn around and look at Pete, who is illuminated by a beam of white light coming from the sky. \n\n" \
	+ "Before you can say anything, Pete is being pulled into the air and without thinking, you jump after him into the blinding light. " \
	+ "The next thing you know is that you wake up in a strange looking environment and Pete is nowhere to be seen. \n\n" \
	+ "Your goal is to explore this unfamiliar environment and rescue Pete."
	
# Called when the node enters the scene tree for the first time.
func _ready():
	#textLabel.text = introText
	scroll_text(introText)


func scroll_text(input_text : String):
	#print_debug(input_text)
	visible_characters = 0
	text = input_text
	
	for i in text.length():
		visible_characters += 1
		await get_tree().create_timer(0.005).timeout
