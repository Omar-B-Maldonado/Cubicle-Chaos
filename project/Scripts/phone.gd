extends Node2D

class_name Phone

#audio
@onready var ringing      = $Ringing
@onready var pick_up      = $PickUp
@onready var hang_up      = $HangUp
@onready var voice        = $Voice
@onready var hang_up_tone = $HangUpTone
@onready var sprite_2d    = $Sprite2D

#functionality
@onready var game_manager = %GameManager
@onready var timer        = $Timer
const GIBBERISH_PATH = "res://gibberish.txt"
var lines_of_text    = []
var answers          = []

#booleans
var is_ringing       = false
var is_talking       = false

# Called when the node enters the scene tree for the first time.
func _ready():
	load_txt_file(GIBBERISH_PATH)
	sprite_2d.visible = false
	timer.start()

func _on_area_2d_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		print("Phone clicked!")
		if not is_ringing:
			hang_up.play()
			hang_up_tone.stop()
			is_talking = false
			sprite_2d.visible = false
			if timer.time_left <= 0: timer.start() #counts down till next phone call

		elif is_ringing:
			pick_up.play()
			ringing.stop()
			is_ringing = false
			sprite_2d.visible = true
			
			var line = get_random_line()
			var words = line.split(' ') #separate the line into words
			answers.clear()

			#add the emails, names, or phone numbers to the set of answers
			for i in range(len(words)):
				var word = words[i]
				if ends_with_punct(word):
					word = cut_off_end_punct(word)
				elif is_upper(word) and i+1 < len(words):
					#check if the next word is uppercase. if so, add both to answers as a name
					var next_word = words[i+1]
					if is_upper(next_word):
						if ends_with_punct(next_word):
							next_word = cut_off_end_punct(next_word)
						answers.append(word + " " + next_word) #FirstName LastName
				
				#adds emails and phone numbers to the list of answers
				if word.contains('@') or word.contains('-'):
					answers.append(word)
			
			await get_tree().create_timer(1).timeout
			is_talking = true
			game_manager.set_subtitle(line)

func _on_timer_timeout():
	is_ringing = true
	ringing.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

static func is_upper(char):
	return char >= 'A' and char <= 'Z'

static func ends_with_punct(string):
	return string.ends_with(',') or string.ends_with('.')

static func cut_off_end_punct(string):
	return string.substr(0, string.length() - 1)

func get_random_line() -> String:
	var random_index = randf_range(0, lines_of_text.size()) as int
	return lines_of_text[random_index]

func load_txt_file(path: String) -> void:
	if FileAccess.file_exists(path):
		var file = FileAccess.open(path, FileAccess.READ)
		while not file.eof_reached():
			lines_of_text.append(file.get_line())
		file.close()
	else: print("File does not exist: ", path)
