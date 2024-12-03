extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	print(get_tree())
	
func _process(_delta):
	change_scene()

func _on_cliff_side_transition_point_body_entered(body):
		if Global.current_scene == "world":
			get_tree().change_scene_to_file("res://scences/cliff_side.tscn")
			Global.finish_changescenes()


func _on_cliff_side_transition_point_body_exited(body):
	if body.name == "player":
		Global.transistion_scene = false

func change_scene():
	if Global.transistion_scene == true:
		if Global.current_scene == "world":
			get_tree().change_scene_to_file("res://scences/cliff_side.tscn")
			Global.finish_changescenes()
		
