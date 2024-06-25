extends Node2D

@onready var total_score = $TotalScore

# Called when the node enters the scene tree for the first time.
func _ready():
	total_score.text = str(Global.score)



func _on_replay_button_pressed():
	Global.score = 0
	get_tree().change_scene_to_file("res://Scenes/game.tscn")
