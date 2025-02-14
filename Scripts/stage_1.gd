extends Node2D

@onready var player_camera = $Player/Camera2D
@onready var player_camera2 = $Player/stage2_cam
@onready var player_camera3 = $Player/stage3_cam

@onready var Bat = $bat_enemy/BatEnemy
@onready var Frog  = $toxic_frog/toxicFrog

var enemy_list = [$"toxicFrog", $"BatEnemy2", $"BatEnemy"]

func _on_something_happened(node_to_destroy):
	node_to_destroy.queue_free()

func _ready():
	
	player_camera.enabled = true
	Global.playerWeaponEquipped = true
	_on_something_happened(player_camera2)
	_on_something_happened(player_camera3)

func _process(delta):
	var clear = get_tree().get_nodes_in_group("enemies").size()
	if clear == 0:
		print("clear")
		get_tree().change_scene_to_file("res://Scenes/stage_2.tscn")
	if !Global.playerAlive:
		Global.gameStarted = false
		get_tree().change_scene_to_file("res://Scenes/lobby.tscn")



#func _on_scene_change_body_entered(body):
	#var enemies = get_tree().get_nodes_in_group("enemies").size()
	#if enemies == 0:
		#print("clear")
		#get_tree().change_scene_to_file("res://Scenes/stage_2.tscn")
