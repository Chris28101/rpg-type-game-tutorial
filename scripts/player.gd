extends CharacterBody2D

var enemy_inattack_range = false
var enemy_attack_cooldown = true
var npc_attack_cooldown = true
var npc_inattack_range = false
var health = 100 
var player_alive = true

var attack_ip = false #ip stands for in progress


const speed = 75
@export var current_dir = "idle"

func _ready():
	$AnimatedSprite2D.play("front_idle")
func _physics_process(delta):
	player_movment(delta)
	enemy_attack()
	attack()
	current_camera()
	update_health()
	NPC_attack()
	NPC_anim()
	if health <= 0:       # respawn screen if u want
		player_alive = false
		health = 0 
		print("player has been killed...")
		self.queue_free()

	

func player_movment(delta):
	
	if Input.is_action_pressed("ui_right"):
		current_dir = "right"
		play_anim(1)
		velocity.x = speed
		velocity.y = 0
	elif Input.is_action_pressed("ui_left"):
		play_anim(1)
		current_dir = "left"
		velocity.x = -speed
		velocity.y = 0
	elif Input.is_action_pressed("ui_down"):
		current_dir = "down"
		play_anim(1)
		velocity.y = speed
		velocity.x = 0
	elif Input.is_action_pressed("ui_up"):
		current_dir = "up"
		play_anim(1)
		velocity.y = -speed
		velocity.x = 0
	else: 
		play_anim(0)
		velocity.x = 0
		velocity.y = 0
	move_and_slide()

func play_anim(movement):
	var dir = current_dir
	var anim = $AnimatedSprite2D
	
	if dir == "right":
		anim.flip_h = false
		if movement == 1:
			anim.play("side_walk")
		elif movement == 0:
			if attack_ip == false:
				anim.play("side_idle")
		
	if dir == "left":
		anim.flip_h = true
		if movement == 1:
			anim.play("side_walk")
		elif movement == 0:
			if attack_ip == false:
				anim.play("side_idle")

	if dir == "down":
		anim.flip_h = true
		if movement == 1:
			anim.play("front_walk")
		elif movement == 0:
			if attack_ip == false:
				anim.play("front_idle")
			
	if dir == "up":
		anim.flip_h = true
		if movement == 1:
			anim.play("back_idle")
		elif movement == 0:
			if attack_ip == false:
				anim.play("back_walk")

func player():
	pass

func _on_player_hitbox_body_entered(body):
	if body.name == "Enemy":
		enemy_inattack_range = true
	if body.name == "NPC":
		npc_inattack_range = true


func _on_player_hitbox_body_exited(body):
	if body.name == "Enemy":
		enemy_inattack_range = false
	if body.name == "NPC":
		npc_inattack_range = false
		


func enemy_attack():
	if enemy_inattack_range and enemy_attack_cooldown == true:
		health = health - 20
		enemy_attack_cooldown = false
		$attack_cooldown.start()
		print(health)
func NPC_attack():
	if npc_inattack_range and npc_attack_cooldown == true:
		#health = health - 20
		npc_attack_cooldown = false
		$attack_cooldown.start()
		print(health)
		
func NPC_anim():
	if current_dir == "left":
		$AnimatedSprite2D.play("side_attack")
		$AnimatedSprite2D.flip_h = true
	if current_dir == "right":
		$AnimatedSprite2D.play("side_attack")
		$AnimatedSprite2D.flip_h = false
	if current_dir == "up":
		$AnimatedSprite2D.play("back_attack")
	if current_dir == "down":
		$AnimatedSprite2D.play("front_attack")


func _on_attack_cooldown_timeout() -> void:
	enemy_attack_cooldown = true
	npc_attack_cooldown = true

func attack():
	var dir = current_dir
	
	if Input.is_action_just_pressed("attack"):
		Global.player_current_attack = true
		attack_ip = true
		if dir == "right":
			$AnimatedSprite2D.flip_h = false
			$AnimatedSprite2D.play("side_attack")
			$deal_attack_timer.start()
		if dir == "left":
			$AnimatedSprite2D.flip_h = true
			$AnimatedSprite2D.play("side_attack")
			$deal_attack_timer.start()
		if dir == "down":
			$AnimatedSprite2D.play("front_attack")
			$deal_attack_timer.start()
		if dir == "up":
			$AnimatedSprite2D.play("back_attack")
			$deal_attack_timer.start()



func _on_deal_attack_timer_timeout() -> void:
	$deal_attack_timer.stop()
	Global.player_current_attack = false
	attack_ip = false
	
	
func current_camera():
	if Global.current_scene == "world":
		$World_camera.enabled = true
		$cliffside_camera.enabled = false
		
	elif Global.current_scene == "cliff_side":
		$World_camera.enabled = false
		$cliffside_camera.enabled = true


func update_health():
	var healthbar = $healthbar
	healthbar.value = health
	
	if health >= 100:
		healthbar.visible = false
	else:
		healthbar.visible = true
	

func _on_regin_timer_timeout() -> void:
	if health <100:
		health = health + 20
		if health > 100:
			health = 100
	if health <= 0:
		health = 0
#fix player anim and npc 
