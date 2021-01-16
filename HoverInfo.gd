extends Control

export(String, MULTILINE) var description = ""


func _on_HoverInfo_mouse_entered():
	var main = get_tree().current_scene
	var expBar = main.find_node("ExpBar")
	var textbox = main.find_node("Textbox")
	if textbox != null:
		textbox.text = description
	if expBar != null:
		expBar.hide()

func _on_HoverInfo_mouse_exited():
	var main = get_tree().current_scene
	var expBar = main.find_node("ExpBar")
	var textbox = main.find_node("Textbox")
	if textbox != null:
		textbox.text = ""  
	if expBar != null:
		expBar.show()
