extends Node2D

# Dictionary to map key names to their corresponding game object nodes
var key_to_object = {}

# This function is called when the node enters the scene tree for the first time
func _ready():
	# Initialize the key-to-object mapping
	key_to_object = {
		KEY_A: $KeyA, KEY_B: $KeyB, KEY_C: $KeyC, KEY_D: $KeyD,
		KEY_E: $KeyE, KEY_F: $KeyF, KEY_G: $KeyG, KEY_H: $KeyH,
		KEY_I: $KeyI, KEY_J: $KeyJ, KEY_K: $KeyK, KEY_L: $KeyL,
		KEY_M: $KeyM, KEY_N: $KeyN, KEY_O: $KeyO, KEY_P: $KeyP,
		KEY_Q: $KeyQ, KEY_R: $KeyR, KEY_S: $KeyS, KEY_T: $KeyT,
		KEY_U: $KeyU, KEY_V: $KeyV, KEY_W: $KeyW, KEY_X: $KeyX,
		KEY_Y: $KeyY, KEY_Z: $KeyZ,
		# Add more mappings as needed
	}
	
	# Ensure the node is set to receive input events
	set_process_input(true)

# This function processes input events
func _input(event):
	# Check if the event is a key press
	if event is InputEventKey and event.pressed:
		# Get the key code
		var key_code = event.keycode

		# Check if the key code exists in the key_to_object dictionary
		if key_to_object.has(key_code):
			# Get the corresponding game object node
			var key_object = key_to_object[key_code]
			
			# Perform an action on the key object
			_on_key_pressed(key_object, key_code)

func _on_key_pressed(key_object, key_code):
	print("Key pressed: ", key_code, ". Node name: ", key_object.name)
	
	# Change the color of the key object to red just to visually verify key presses
	key_object.modulate = Color(1, 0, 0, 1)
