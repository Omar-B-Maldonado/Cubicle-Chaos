extends Node2D

@onready var keyboard = %Keyboard

@onready var collision_shape_2d = $Area2D/CollisionShape2D


func _on_area_2d_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		collision_shape_2d.disabled = true
		keyboard.visible = true
		keyboard.collision_shape_2d.disabled = false
