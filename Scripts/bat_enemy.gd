extends CharacterBody2D

class_name BatEnemy

const speed = 30
var dir: Vector2
 
var is_bat_chase: bool

var player: CharacterBody2D

var health = 50
var health_max = 50
var health_min = 0
var dead = false 
var taking_damage = false
var is_roaming: bool
var damage_to_deal = 5

func _ready():
	is_bat_chase = true
	Global.batBody = self
	
func move(delta):
	player = Global.playerBody

	if !dead:
		is_roaming = true
		if !taking_damage and is_bat_chase and Global.playerAlive:
			velocity = position.direction_to(player.position) * speed
			dir.x = abs(velocity.x)/ velocity.x
		elif taking_damage:
			var knockback_dir = position.direction_to(player.position) * -50
			velocity = knockback_dir
		else:
			velocity += dir * speed  *delta
			
	elif dead:
		velocity.y += 10 *delta
		velocity.x = 0
	move_and_slide()
	update_health()
	
func _process(delta):
		Global.batDamageAmount = damage_to_deal
		Global.batDamageZone = $BatDealDamageArea
		if Global.playerAlive:
			is_bat_chase = true
		elif !Global.playerAlive:
			is_bat_chase = false
		if  is_on_floor() and dead:
			await get_tree().create_timer(3.0).timeout
			self.queue_free()
		move(delta)
		handle_animation()

func _on_timer_timeout():
	$Timer.wait_time = choose([0.5,0.8])
	if !is_bat_chase:
		dir = choose([Vector2.RIGHT, Vector2.UP, Vector2.LEFT, Vector2.DOWN])

func handle_animation():
	var animated_sprite = $AnimatedSprite2D
	if !dead and !taking_damage:
		animated_sprite.play("fly")
		if dir.x == -1:
			animated_sprite.flip_h = true
		elif dir.x == 1:
			animated_sprite.flip_h = false
	elif !dead and taking_damage:
		animated_sprite.play("hurt")
		await get_tree().create_timer(0.8).timeout
		taking_damage = false
	elif dead and is_roaming:
		is_roaming = false
		
		animated_sprite.play("death")
		set_collision_layer_value(1,true)
		set_collision_layer_value(2, false)
		set_collision_mask_value(1, true)
		set_collision_mask_value(2, false)
		

func choose(array):
	array.shuffle()
	return array.front()


func _on_bat_hitbox_area_entered(area: Area2D) -> void:
	if area == Global.playerDamageZone:
		var damage = Global.playerDamageAmount
		take_damage(damage)

func take_damage(damage):
	health -= damage
	taking_damage = true
	if health <= 0:
		Global.add_point()
		update_score_label()
		health = 0
		dead = true
	print(str(self), "current health is ", health)
	
func update_health():
	var healthbar = $healthbar
	healthbar.value = health
	
	if health >= 50:
		healthbar.visible = false
	else:
		healthbar.visible = true
		
		
@onready var coin_label = $"../Player/Camera2D/CanvasLayer/Control/CoinLabel"		
		
func update_score_label():
	coin_label.text = "Score: " + str(Global.score)
		
