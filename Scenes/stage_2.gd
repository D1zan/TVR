extends Node2D

@onready var player_camera = $Player/Camera2D
@onready var player_camera2 = $Player/stage2_cam

func _on_something_happened(node_to_destroy):
	node_to_destroy.queue_free()

func _ready():
	
	player_camera.enabled = true
	Global.playerWeaponEquipped = true
	_on_something_happened(player_camera)
func _process(delta):
	var clear = get_tree().get_nodes_in_group("enemies").size()
	if clear == 0:
		get_tree().change_scene_to_file("res://Scenes/stage_2.tscn")
	if !Global.playerAlive:
		Global.gameStarted = false
		get_tree().change_scene_to_file("res://Scenes/lobby.tscn")
