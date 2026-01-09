extends CharacterBody2D


var speed = 40

var player = null

var health = 80
var attack = 40
var lvl = 1
var moves = {
	"Waterfall": 40,
	"Hydropump": 50,
	"Zenheadpump": 30,
	"Icebeam": 25
	}

var player_inattack_zone = false




func _physics_process(delta):
	pass
	
	
	
func _on_detection_area_body_entered(body):
	player = body



func _on_detection_area_body_exited(body):
	player = null




func _on_enemy_hitbox_body_entered(body):
	if body.name == "player":
		player_inattack_zone = true


func _on_enemy_hitbox_body_exited(body):
	if body.name == "player":
		player_inattack_zone = false

#func deal_with_damage():
	#if player_inattack_zone and Global.player_current_attack == true:
		#health = health - 20
		#print("slime health", health)
		#if health <= 0:
			#self.queue_free()
