$Camera2D.current = true
func _process(delta):
	var player = preload("res://Player.tscn").instantiate()
	add_child(player)
	
