extends Timer

var spawnAreas = []

func _ready():
	self.start()
	spawnAreas.append($SpawnArea1.position)
	spawnAreas.append($SpawnArea2.position)
	spawnAreas.append($SpawnArea3.position)	
	self.wait_time = 10

func _SpawnWorker():
	
	var randomNum = randf_range(-1,spawnAreas.size())
	var workerNode = preload("res://Scenes/worker.tscn")
	var instance = workerNode.instantiate()
	
	add_child(instance)
	instance.position = spawnAreas[randomNum]
	
func _on_timeout():
	_SpawnWorker()
