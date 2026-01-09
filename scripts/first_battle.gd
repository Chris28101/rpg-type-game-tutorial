extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	change_scenes()


func _on_clifeside_exit_body_entered(body):
	if body.name == "player": 
		Global.transistion_scene = true


func _on_clifeside_exit_body_exited(body):
	if body.name == "player":
		Global.transistion_scene = false
		
func change_scenes():
	if Global.transistion_scene == true:
		if Global.current_scene == "cliff_side":
			get_tree().change_scene_to_file("res://scences/world.tscn")
			Global.finish_changescenes()
