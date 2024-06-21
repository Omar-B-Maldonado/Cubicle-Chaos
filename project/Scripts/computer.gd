extends Node2D

class_name Computer

@onready var game_manager  = %GameManager
@onready var email_content = $Screen/EmailContent
@onready var button        = $Screen/Button
@onready var screen_area   = $Screen/ScreenArea

static var answer_set = []

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

static func add_answers(answers):
	answer_set.append(answers)

func _on_button_pressed():
	var email_answers = []
	var email_text = email_content.text.strip_edges()  # Trim any leading/trailing whitespace
	email_text     = email_text.replace("\n", " ") # Replace newlines with spaces
	var words      = email_text.split(' ')
	print(email_text)
	#add the emails, names, or phone numbers to the set of answers
	for i in range(len(words)):
		var word = words[i]
		if phone.ends_with_punct(word):
			word = phone.cut_off_end_punct(word)
		elif phone.is_upper(word) and i+1 < len(words):
			#check if the next word is uppercase. if so, add both to answers as a name
			var next_word = words[i+1]
			if phone.is_upper(next_word):
				if phone.ends_with_punct(next_word):
					next_word = phone.cut_off_end_punct(next_word)
				email_answers.append(word + " " + next_word) #FirstName LastName
		
		#adds emails and phone numbers to the list of answers
		if word.contains('@') or word.contains('-'):
			email_answers.append(word)
	
	print("Email answers:", email_answers)  # Debug print
	cross_check(email_answers)
	print(game_manager.score)
	email_content.clear()
	
func cross_check(answers):
	print("crosschecking", answers)
	print("against ", answer_set)
	
	for word in answers:
		for arr in answer_set:
			if word in arr:
				game_manager.add_points(1)
				break
