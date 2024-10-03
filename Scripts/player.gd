extends CharacterBody2D

@onready var animated_sprite = $AnimatedSprite2D

const speed = 300.0
const jump_power = -350.0

var gravity = 900.0

var weapon_equip: bool 

func _ready():
	weapon_equip = true


func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	  
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_power
	
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

	move_and_slide()
	handle_movement_animation(direction)

func handle_movement_animation(dir):
	if !weapon_equip:
		if is_on_floor():
			if !velocity:
				animated_sprite.play("idle")
			if velocity:
				animated_sprite.play("run")
				toogle_flip_sprite(dir)
		elif !is_on_floor():
			animated_sprite.play("fall")
	if weapon_equip:
		if is_on_floor():
			if !velocity:
				animated_sprite.play("WeaponIdle")
			if velocity:
				animated_sprite.play("weapon_run")
				toogle_flip_sprite(dir)
		elif !is_on_floor():
			animated_sprite.play("weapon_fall")
func toogle_flip_sprite(dir):
	if dir == 1:
		animated_sprite.flip_h = false
	if dir == -1:
		animated_sprite.flip_h = true
