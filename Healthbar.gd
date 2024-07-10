extends ProgressBar

var parent
var max_value_amount

func _ready():
	parent = get_parent()
	max_value_amount = parent.health
	
func _process(delta):
	self.value = parent.health
	if parent.health != max_value_amount:
		self.visible = true
		if parent.health == 0:
			self.visible = false
	else:
		self.visible = false
