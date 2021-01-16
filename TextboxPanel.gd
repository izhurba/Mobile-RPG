extends Panel

onready var expBar = $ExpBar
onready var lvlLabel = $Level

func _on_PlayerStats_exp_changed(value):
	expBar.value += value
	if expBar.value >= expBar.max_value:
		pass


func _on_PlayerStats_lvl_changed(value):
	pass
