extends Control


func resume():
	get_tree().paused = false
	
func pause():
	get_tree().paused = true
	
func testEsc():
	if Input.is_action_just_pressed("esc") and !get_tree().paused:
		pause()
	elif Input.is_action_just_pressed("esc") and !get_tree().paused:
		resume()


func _on_resume_pressed() -> void:
	resume()


func _on_settings_pressed() -> void:
	print("Settings")


func _on_returntomenu_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
