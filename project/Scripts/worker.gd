extends Node

var typeofDocument: DocumentArea.Document
@onready var game_manager         = GameManager
@export var workerSprite: Sprite2D
@export var labelDocument: Label
# Called when the node enters the scene tree for the first time.
func _ready():
	var randomNum = randf_range(0, DocumentArea.Document.size())
	typeofDocument = randomNum
	
	_assign_label_color()
	labelDocument.text += "" + DocumentArea.Document.keys()[typeofDocument]
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _on_worker_timer_timeout():
	self.queue_free()

func _on_worker_area_area_entered(area):
	var doc = area as DocumentArea
	
	if area is DocumentArea and area.typeofDocument == typeofDocument:
		doc.documentNode.visible = false
		doc.documentNode.disabled = true
		game_manager.add_points(1)
		self.queue_free()
		
		print("Right")
	else:
		doc.documentNode.visible = false
		doc.documentNode.disabled = true
		workerSprite.modulate = Color.RED
		print("Wrong")
		
func _assign_label_color():
	match typeofDocument:
		DocumentArea.Document.LETTER:
			labelDocument.modulate = Color.RED
		DocumentArea.Document.REPORT:
			labelDocument.modulate = Color.BLUE
		DocumentArea.Document.CONTRACT:
			labelDocument.modulate = Color.GREEN
		
