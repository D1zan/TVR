extends Node2D

@onready var player_camera = $Player/Camera2D

func _ready():
	player_camera.enabled = true
	Global.playerWeaponEquipped = true
