extends Area2D

# Einstellen welcher Charakter die Interaktion ausführt
@export var interactor : Node2D
# Festlegen, dass über einen Tastendruck interagiert werden kann
@export var interaction_action : StringName = "interact"

var selected_interactable : Interactable
var nearby_interactables : Array[Interactable]

# Label to show interactions
@onready var interaction_pop_p = $InteractionPanel
@onready var interaction_pop_l = $InteractionPanel/InteractionLabel

# Called when the node enters the scene tree for the first time.
func _ready():
	area_entered.connect(_on_area_entered)
	area_exited.connect(_on_area_exited)
	# Hide overhead panel for interactions
	interaction_pop_p.hide()
	interaction_pop_l.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(nearby_interactables.size() > 0):
		interaction_pop_p.visible = true
		interaction_pop_l.visible = true
	else:
		interaction_pop_p.visible = false
		interaction_pop_l.visible = false

func _input(event : InputEvent):
	if(event.is_action_pressed(interaction_action)): # Spieler hat den Interaction-Key gedrückt
		if(selected_interactable != null):
			selected_interactable.interact(interactor) # Interaktor (Player) als Parameter übergeben

func _on_area_entered(area : Area2D):
	if(area is Interactable):
		nearby_interactables.push_back(area)
		
		if(selected_interactable == null):
			selected_interactable = nearby_interactables[0]

func _on_area_exited(area : Area2D):
	if(area is Interactable):
		nearby_interactables.erase(area)
		
		selected_interactable.stop_interaction(interactor)
		
		if(nearby_interactables.size() > 0):
			selected_interactable = nearby_interactables[0]
		else:
			selected_interactable = null
