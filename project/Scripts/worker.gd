extends Node

var typeofDocument: DocumentArea.Document
@onready var game_manager         = GameManager
@export var workerSprite: Sprite2D
@export var workerText: Label
# Called when the node enters the scene tree for the first time.
func _ready():
	var randomNum = randf_range(0, DocumentArea.Document.size())
	typeofDocument = randomNum
	
	workerText.text += "" + DocumentArea.Document.keys()[typeofDocument]
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _on_worker_timer_timeout():
	self.queue_free()

func _on_worker_area_area_entered(area):
	if area is DocumentArea and area.typeofDocument == typeofDocument:
		var doc = area as DocumentArea
		doc.documentNode.visible = false
		game_manager.add_points(1)
		self.queue_free()
		print("Right")
	else:
		workerSprite.modulate = Color.RED
		workerText.text = "NO! I SAID a " + DocumentArea.Document.keys()[typeofDocument]
		print("Wrong")
