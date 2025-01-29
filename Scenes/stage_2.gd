extends Node2D


@onready var player_camera = $Player/stage2_cam

func _ready():
	player_camera.enabled = true
	Global.playerWeaponEquipped = true

func _process(delta):
	if !Global.playerAlive:
		Global.gameStarted = false
		get_tree().change_scene_to_file("res://Scenes/lobby.tscn")
