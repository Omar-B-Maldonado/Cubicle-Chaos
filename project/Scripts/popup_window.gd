extends Node2D

var game_manager

func set_manager(manager):
	game_manager = manager
	
func _ready():
	pass
	

func _on_x_button_pressed():
	queue_free()



func _on_tree_exiting():
	game_manager.on_popup_closed(self)
