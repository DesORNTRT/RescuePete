extends Node2D

@onready var move_pop_p = $MovePopP
@onready var move_pop_l = $MovePopP/MovePopL
@onready var jump_pop_p = $JumpPopP
@onready var jump_pop_l = $JumpPopP/JumpPopL
@onready var interact_pop_p = $InteractPopP
@onready var interact_pop_l = $InteractPopP/InteractPopL
@onready var fight_pop_p = $FightPopP2
@onready var fight_pop_l = $FightPopP2/FightPopL
@onready var portal_pop_p = $PortalPopP
@onready var portal_pop_l = $PortalPopP/PortalPopL
var enemy_defeated = false
@onready var enemy = $Enemy

func _ready():
	move_pop_p.hide()
	move_pop_l.hide()
	jump_pop_p.hide()
	jump_pop_l.hide()
	interact_pop_p.hide()
	interact_pop_l.hide()
	fight_pop_p.hide()
	fight_pop_l.hide()
	portal_pop_p.hide()
	portal_pop_l.hide()
	Global.current_scene = "res://Scenes/levels/level_1.tscn"
	Global.lives = 5
	enemy.connect("enemy_defeated", Callable(self, "_on_enemy_defeated"))

func _on_enemy_defeated():
	enemy_defeated = true
	print("Signal erhalten")

func _on_area_2d_body_entered_MovePop(body):
	if body.name == "Player":
		move_pop_p.visible = true
		move_pop_l.visible = true

func _on_area_2d_body_exited_MovePop(body):
	if body.name == "Player":
		move_pop_p.visible = false
		move_pop_l.visible = false

func _on_jump_area_body_entered(body):
	if body.name == "Player":
		jump_pop_p.visible = true
		jump_pop_l.visible = true

func _on_jump_area_body_exited(body):
	if body.name == "Player":
		jump_pop_p.visible = false
		jump_pop_l.visible = false

func _on_interact_area_body_entered(body):
	if body.name == "Player":
		interact_pop_p.visible = true
		interact_pop_l.visible = true

func _on_interact_area_body_exited(body):
	if body.name == "Player":
		interact_pop_p.visible = false
		interact_pop_l.visible = false

func _on_fight_area_body_entered(body):
	if body.name == "Player":
		fight_pop_p.visible = true
		fight_pop_l.visible = true

func _on_fight_area_body_exited(body):
	if body.name == "Player":
		fight_pop_p.visible = false
		fight_pop_l.visible = false

func _on_portal_2_player_entered_teleporter(body):
	if body.name == "Player" and enemy_defeated:
		#get_tree().change_scene_to_file("res://Scenes/levels/level_2.tscn")
		get_tree().call_deferred("change_scene_to_file","res://Scenes/levels/level_2.tscn")
	elif body.name == "Player" and not enemy_defeated:
		portal_pop_p.visible = true
		portal_pop_l.visible = true

func _on_portal_2_player_exited_teleporter(body):
	if body.name == "Player":
		portal_pop_p.visible = false
		portal_pop_l.visible = false

