extends "res://Actions/ActionButton.gd"

onready var info = $HoverInfo

func _ready():
	info.description = "Heals 15 hp\n" + "Costs 10 mp and 3 ap"

func _on_pressed():
	var playerStats = BattleUnits.PlayerStats
	if playerStats != null:
		if playerStats.mp >= 10 and playerStats.ap >= 3:
			playerStats.hp += 15
			playerStats.mp -= 10
			playerStats.ap -= 3
			
