extends Node

@onready var subtitle = $Subtitle
@onready var phone    = $Phone
@onready var voice    = %Voice
@onready var computer = $Computer
@onready var score    = $Score
var popup_scene     = load("res://Scenes/popup_window.tscn")
var active_popups   = []
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
	create_popup()
	
	#wait 5 seconds after all text is shown to cut it all off
	await get_tree().create_timer(5).timeout
	if subtitle.visible_ratio == 1.0: phone.hang_up_tone.play()
	subtitle.text = ""
		
func randomize_pitch(audio_player):
	audio_player.pitch_scale = randf_range(0.7, 1.5)
	
func add_points(num):
	points += num
	score.text = "Score: " + str(points)

func create_popup():
	var popup_instance = popup_scene.instantiate()
	popup_instance.set_manager(self)
	add_child(popup_instance)
	active_popups.append(popup_instance)
	computer.email_content.set_editable(false)
	computer.email_content.mouse_filter = Control.MOUSE_FILTER_IGNORE  # Ignore mouse interactions
	computer.button.mouse_filter        = Control.MOUSE_FILTER_IGNORE
	
func on_popup_closed(popup):
	active_popups.erase(popup)
	if active_popups.is_empty():
		computer.email_content.set_editable(true)
		computer.email_content.mouse_filter = Control.MOUSE_FILTER_STOP  # Allow mouse interactions again
		computer.button.mouse_filter        = Control.MOUSE_FILTER_STOP


