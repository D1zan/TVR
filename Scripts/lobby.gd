extends Node2D


@onready var player_camera = $Player/Camera2D

func _ready():
	player_camera.enabled = false
	Global.playerWeaponEquipped = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
