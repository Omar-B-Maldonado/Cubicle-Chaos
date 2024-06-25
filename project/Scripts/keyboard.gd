extends Node2D
@onready var collision_shape_2d = $Area2D/CollisionShape2D
@onready var keyboard_static = %KeyboardStatic

# Dictionary to map key names to their corresponding game object nodes
var key_to_object = {}
var originalColor 
var pressedColor
# This function is called when the node enters the scene tree for the first time
func _ready():
	originalColor = $KeyA.modulate
	pressedColor = Color.DIM_GRAY
	# Initialize the key-to-object mapping
	key_to_object = {
		KEY_A: $KeyA, KEY_B: $KeyB, KEY_C: $KeyC, KEY_D: $KeyD,
		KEY_E: $KeyE, KEY_F: $KeyF, KEY_G: $KeyG, KEY_H: $KeyH,
		KEY_I: $KeyI, KEY_J: $KeyJ, KEY_K: $KeyK, KEY_L: $KeyL,
		KEY_M: $KeyM, KEY_N: $KeyN, KEY_O: $KeyO, KEY_P: $KeyP,
		KEY_Q: $KeyQ, KEY_R: $KeyR, KEY_S: $KeyS, KEY_T: $KeyT,
		KEY_U: $KeyU, KEY_V: $KeyV, KEY_W: $KeyW, KEY_X: $KeyX,
		KEY_Y: $KeyY, KEY_Z: $KeyZ, KEY_MINUS: $KeyMinus, KEY_PERIOD: $KeyPeriod,
		KEY_SPACE: $KeySpace, KEY_ENTER: $KeyEnter, KEY_QUOTELEFT: $KeyAt,
		KEY_0: $Key0, KEY_1: $Key1, KEY_2: $Key2, KEY_3: $Key3 , KEY_4: $Key4,
		KEY_5: $Key5, KEY_6: $Key6, KEY_7: $Key7, KEY_8: $Key8 , KEY_9: $Key9,
		KEY_BACKSPACE: $KeyBackspace, KEY_SHIFT: $KeyShift
		# Add more mappings as needed
	}
	
	# Ensure the node is set to receive input events
	set_process_input(true)
	self.visible = false

func _input(event):
	if event is InputEventKey and key_to_object.has(event.keycode):		
		var key_object = key_to_object[event.keycode]
		
		if event.pressed:
			print("Key pressed: ", event.keycode, ". Node name: ", key_object.name)
			key_object.modulate = pressedColor
			
		if event.is_released():
			key_object.modulate = originalColor


func _on_area_2d_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		self.visible = false
		collision_shape_2d.disabled = true
		keyboard_static.collision_shape_2d.disabled = false
		
