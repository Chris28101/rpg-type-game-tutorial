extends Node

var player_current_attack = false

var current_scene = "world" 
var transistion_scene = false

var player_exit_cliffside_posx = 0
var player_exit_cliffside_posy = 0
var player_start_posx = 0
var player_start_posy = 0
 
func finish_changescenes():
	if transistion_scene == true:
		transistion_scene == false
		if current_scene == "world":
			current_scene = "cliff_side"
		else: 
			current_scene = "world"
