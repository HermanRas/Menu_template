extends Control
	
func _input(event):
	if Input.is_action_pressed("UP"):
		print("UP!!")
	if Input.is_action_pressed("SHOOT"):
		print("shooting!!")

func _on_playBtn_pressed():
	Transit.change_scene("res://fakeGame/fakeGame.tscn")

func _on_settingsBtn_pressed():
	var _sceneState
	_sceneState= get_tree().change_scene("res://Menu/SettingsMenu/SettingsMenu.tscn")


func _on_quitBtn_pressed():
	get_tree().quit()
