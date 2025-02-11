extends CharacterBody2D

@export var SPEED = 100

var direction : float
var spawnPos : Vector2
var spawnRot : float
var zdex : int


func _ready():
	set_as_top_level(true)
	global_position = spawnPos
	global_rotation = spawnRot
	
func _physics_process(delta):
	velocity = Vector2(0,-SPEED).rotated(direction)
	move_and_slide()
	
	
	
	


func _on_visible_on_screen_enabler_2d_screen_exited() -> void:
	queue_free()
