extends Area2D
class_name DocumentArea

enum Document {CONTRACT, REPORT, LETTER}

@export var documentNode: Node2D
@export var typeofDocument: Document
@export var glow: ColorRect

var isAreaActive: bool = false
var isDragging: bool = false

var originalPosition: Vector2
# Called when the node enters the scene tree for the first time.
func _ready():
	originalPosition = documentNode.position
	set_process_input(true)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if isDragging == true:
		Drag()

func _mouse_enter():
	print("Entering!")
	isAreaActive = true
	glow.visible = true
	

func _mouse_exit():
	print("Exiting")
	isAreaActive = false;
	glow.visible = false
	
func _input(event):
	if event is InputEventMouseButton and event.button_index == 1:
		if isAreaActive == true and event.is_pressed():
			documentNode.visible = true
			isDragging = true
			print("LMB clicked")
		elif event.is_released():
			isDragging = false
			documentNode.position = originalPosition
			documentNode.visible = false
			print("LMB Released")
			

func Drag():
	documentNode.global_position = get_global_mouse_position()
