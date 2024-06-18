extends Node2D

@onready var timer   = $Timer
const GIBBERISH_PATH = "res://gibberish.txt"
var lines_of_text    = []
var answers          = []

# Called when the node enters the scene tree for the first time.
func _ready():
	load_txt_file(GIBBERISH_PATH)
	timer.start() #looping timer starts

func _on_timer_timeout():
	var line = get_random_line() #random gibberish line is gotten when the timer runs out
	print(line)
	var words = line.split(' ') #separate the line into words
	#check if the words are emails, names, or phone numbers
	#add the email, name, or phone number to the answers
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
	print(answers)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func is_upper(char):
	return char >= 'A' and char <= 'Z'

func ends_with_punct(string):
	return string.ends_with(',') or string.ends_with('.')

func cut_off_end_punct(string):
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
