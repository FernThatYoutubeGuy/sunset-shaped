extends Control

var editing = false
var action_string
enum ACTIONS {left, right, jump}

func _ready():
	_set_keys()  
  
func _set_keys():
	for action in ACTIONS:
		print(action)
		get_node(str(action) + "/TextureButton").set_pressed(false)
		if !InputMap.get_action_list(action).empty():
			get_node(str(action) + "/TextureButton/RichTextLabel2").bbcode_text = "[center]" + InputMap.get_action_list(action)[0].as_text()
		else:
			get_node(str(action) + "/TextureButton/RichTextLabel2").bbcode_text = "[center]No Button!"

func change_key_left():
	_mark_button("left")

func change_key_right():
	_mark_button("right")

func change_key_jump():
	_mark_button("jump")

func _mark_button(string):
	editing = true
	action_string = string
	
	for action in ACTIONS:
		if action != string:
			get_node(str(action) + "/TextureButton").set_pressed(false)

func _input(event):
	if event is InputEventKey: 
		if editing:
			_change_key(event)
			editing = false

func _change_key(new_key):
	#Delete key of pressed button
	if !InputMap.get_action_list(action_string).empty():
		InputMap.action_erase_event(action_string, InputMap.get_action_list(action_string)[0])
	
	#Check if new key was assigned somewhere
	for i in ACTIONS:
		if InputMap.action_has_event(i, new_key):
			InputMap.action_erase_event(i, new_key)
			
	#Add new Key
	InputMap.action_add_event(action_string, new_key)
	
	_set_keys()
