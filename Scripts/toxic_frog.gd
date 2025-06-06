extends CharacterBody2D


class_name FrogEnemy

const speed = 30 
var is_frog_chase: bool = true

var health = 80
var health_max = 80
var health_min = 0

var dead: bool = false
var taking_damage: bool = false
var damage_to_deal = 10
var is_dealing_damage: bool = false

var dir: Vector2
const gravity = 900
var knockback_force = -20
var is_roaming: bool = true

var player: CharacterBody2D
var player_in_area = false 

func _process(delta: float) -> void:
	if !is_on_floor():
		velocity.y += gravity *delta
		velocity.x = 0
	Global.frogDamageAmount	= damage_to_deal
	Global.frogDamageZone = $frogDealDamageArea
	player = Global.playerBody
	move(delta)
	handle_animation()
	move_and_slide()
	update_health()

#the ! makes the function or if statement opposite 
func move(delta):
#If the player is not dead AND if the frog chase
#if the player is not chasing the frog!!!!!!
	if !dead:
		if !is_frog_chase:
			velocity += dir * speed * delta
		elif is_frog_chase and !taking_damage:
			var dir_to_player = position.direction_to(player.position) *speed 
			velocity.x = dir_to_player.x
			dir.x = abs(velocity.x)/ velocity.x
		elif taking_damage:
			var knockback_dir = position.direction_to(player.position) * knockback_force
			velocity.x = knockback_dir.x
		is_roaming = true
	elif dead:
		velocity.x = 0
func handle_animation():
	var anim_sprite = $AnimatedSprite2D
	if !dead and !taking_damage and !is_dealing_damage:
		anim_sprite.play("walk")
		if dir.x == - 1:
			anim_sprite.flip_h = true
		elif dir.x == 1:
			anim_sprite.flip_h = false
	elif !dead and taking_damage and !is_dealing_damage:
		anim_sprite.play("hurt")
		await get_tree().create_timer(0.8).timeout
		taking_damage = false
	elif dead and is_roaming:
		is_roaming = false
		anim_sprite.play("death")
		await get_tree().create_timer(1.0).timeout 
		handle_death()
	
func handle_death():
	self.queue_free() 
#function will kill player 
func _on_direction_timer_timeout() -> void:
	$DirectionTimer.wait_time = choose([1.5,2.0,2.5])
	if !is_frog_chase:
		dir = choose([Vector2.RIGHT,Vector2.LEFT])
		velocity.x = 0
	
func choose (array):
	array.shuffle()
	return array.front()


func _on_froghitbox_area_entered(area: Area2D) -> void:
	var damage = Global.playerDamageAmount
	if area == Global.playerDamageZone:
		take_damage(damage)
func take_damage(damage):
	health -= damage
	taking_damage = true
	if health <= health_min:
		health = health_min
		dead = true
		Global.add_point()
		update_score_label()
	print(str(self), "current health is ", health)
	

func update_health():
	var healthbar = $healthbar
	healthbar.value = health
	
	if health >= 80:
		healthbar.visible = false
	else:
		healthbar.visible = true
		
@onready var coin_label = $"../Player/Camera2D/CanvasLayer/Control/CoinLabel"				
		
func update_score_label():
	coin_label.text = "Score: " + str(Global.score)
