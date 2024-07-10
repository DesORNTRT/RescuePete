extends CanvasLayer

func _ready():
	Global.hud = self
	Global.lives = 5
	load_hearts()

func load_hearts():
	var heart_width = 16
	
	# Ensure proper initial sizes
	$HeartsFull.size.x = Global.lives * heart_width
	$HeartsEmpty.size.x = (Global.max_lives - Global.lives) * heart_width
	
	# Ensure proper initial position
	if Global.lives == Global.max_lives :
		$HeartsEmpty.position.x = $HeartsFull.position.x
	elif Global.lives == 0:
		$HeartsEmpty.size.x = Global.max_lives * heart_width
		$HeartsEmpty.position.x = $HeartsFull.position.x
		$HeartsFull.size.x = 0
	else : 
		$HeartsEmpty.position.x = $HeartsFull.position.x + $HeartsFull.size.x 
