extends Node2D



@onready var player_camera = $Player/Camera2D

func _ready():
	player_camera.enabled = false
	Global.playerWeaponEquipped = false


# Called every frame. 'delta' is the elapsed time since the previous frame.

func _on_load_detect_body_entered(body):
	if body is Player:
		Global.gameStarted = true 
		get_tree().change_scene_to_file("res://Scenes/stage_1.tscn")


func _on_house_1_child_entered_tree(node: Node) -> void:
	var current_scene_file = get_tree().current_scene.scene_file_path
	print(current_scene_file)
	var shop_level_number = current_scene_file.to_int() + 1
	print(shop_level_number)
	var shop_level_path = "res://Scenes/shop_level"
	pass # Replace with function body.
