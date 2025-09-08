extends Node2D

var health = 120
var speed = 40
var player_chase = false

var player = null

var player_inattack_zone = false
var can_take_damage = true

func _physics_process(delta: float) -> void:
	update_health()
	deal_with_damage()
	if player_chase:
		position += (player.position - position)/speed
		
		if player.current_dir == "right":
			$AnimatedSprite2D.flip_h = false
			$AnimatedSprite2D.play("side_walk")
		elif player.current_dir == "left":
			$AnimatedSprite2D.flip_h = true
			$AnimatedSprite2D.play("side_walk")
		elif player.current_dir == "down":
			$AnimatedSprite2D.play("front_walk")
		elif player.current_dir == "up":
			$AnimatedSprite2D.play("back_walk")
	else:
		$AnimatedSprite2D.play("front_idle")



func _on_detection_body_entered(body):
	player = body
	player_chase = true




func _on_detection_body_exited(body):
	player = null
	player_chase = false

func npc():
	pass


func _on_npc_hitbox_body_entered(body):
	if body.name == "player":
		player_inattack_zone = true


func _on_npc_hitbox_body_exited(body):
	if body.name == "player":
		player_inattack_zone = false


func deal_with_damage():
	if player_inattack_zone and Global.player_current_attack == true:
		if can_take_damage == true:
			health = health - 20
			$take_damage_cooldown.start()
			can_take_damage = false
			print("npc health is:", health)
			if health <= 0:
				print("npc died")
				self.queue_free()


func _on_take_damage_cooldown_timeout() -> void:
	can_take_damage = true
	
func update_health():
	var healthbar = $healthbar
	healthbar.value = health
	
	if health >= 100:
		healthbar.visible = false
	else:
		healthbar.visible = true
