extends Node
@onready var subtitle = $Subtitle
@onready var phone    = $Phone
@onready var voice    = %Voice
@onready var computer = $Computer
@onready var score    = $Score

var voice_trigger   = 0
var current_answers = ""
var points          = 0

func set_subtitle(line):
	subtitle.text = line
	subtitle.visible_characters = 0
	for i in subtitle.text:
		if phone.is_talking:
			subtitle.visible_characters += 1
			voice_trigger += 1
			if voice_trigger == 2:
				randomize_pitch(phone.voice)
				phone.voice.play()
				voice_trigger = 0
			await get_tree().create_timer(0.05).timeout
		else: #cut off text if they stop talking because you hung up
			subtitle.text = ""
			break
	current_answers = phone.answers
	Computer.add_answers(current_answers)
	
	#wait 5 seconds after all text is shown to cut it all off
	await get_tree().create_timer(5).timeout
	if subtitle.visible_ratio == 1.0: phone.hang_up_tone.play()
	subtitle.text = ""
		
func randomize_pitch(audio_player):
	audio_player.pitch_scale = randf_range(0.7, 1.5)
	
func add_points(num):
	points += num
	score.text = "Score: " + str(points)
