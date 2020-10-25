extends Control

var can_change_key = false
var action_string
const keyPath = "NinePatchRect/VBoxContainer/KeyBindings/ScrollBar/VBoxContainer/HBoxCont_"
enum ACTIONS {JUMP, CROUCH, SHOOT, UP, DOWN, LEFT, RIGHT}

func _ready():
	_set_keys()  
  
func _set_keys():
	for j in ACTIONS:
		get_node(keyPath + str(j) + "/Button").set_pressed(false)
		if !InputMap.get_action_list(j).empty():
			if "InputEventMouseButton" in InputMap.get_action_list(j)[0].as_text():
				get_node(keyPath + str(j) + "/Button").set_text("MouseBtn:"+str(InputMap.get_action_list(j)[0].button_index))
			else:
				get_node(keyPath + str(j) + "/Button").set_text(InputMap.get_action_list(j)[0].as_text())
		else:
			get_node(keyPath + str(j) + "/Button").set_text("No Button!")


func _on_b_UP_pressed():
	_mark_button("UP")
	
func _on_b_DOWN_pressed():
	_mark_button("DOWN")
	
func _on_b_LEFT_pressed():
	_mark_button("LEFT")
	
func _on_b_RIGHT_pressed():
	_mark_button("RIGHT")

func _on_b_JUMP_pressed():
	_mark_button("JUMP")

func _on_b_CROUCH_pressed():
	_mark_button("CROUCH")

func _on_b_SHOOT_pressed():
	_mark_button("SHOOT")

func _mark_button(string):
	can_change_key = true
	action_string = string
	
	for j in ACTIONS:
		if j != string:
			get_node(keyPath + str(j) + "/Button").set_pressed(false)

func _input(event):
	if event is InputEventKey || event is InputEventMouseButton:
		if can_change_key:
			_change_key(event)
			can_change_key = false

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

func _on_backBtn_pressed():
	var _sceneState
	_sceneState= get_tree().change_scene("res://Menu/MainMenu.tscn")

func _on_CheckButton_toggled(_button_pressed):
	OS.window_fullscreen = !OS.window_fullscreen

func _on_VolumeSpin_value_changed(value):
		var set_vol = (value / 2.5) - 26
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), set_vol)
