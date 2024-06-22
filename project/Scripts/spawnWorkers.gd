extends Timer

func _ready():
	self.start()

func _SpawnWorker():
	
	var randomNum = randf_range(0,300)
	var randomPosition = Vector2(randomNum, randomNum)
	var workerNode = preload("res://Scenes/worker.tscn")
	var instance = workerNode.instantiate()
	
	add_child(instance)
	instance.position = randomPosition
	
func _on_timeout():
	_SpawnWorker()
