extends "res://Actions/ActionButton.gd"

onready var info = $HoverInfo

func _ready():
	info.description = "Heals 5 hp\n" + "Costs 4 mp"

func _on_pressed():
	var playerStats = BattleUnits.PlayerStats
	if playerStats != null:
		if playerStats.mp >= 4:
			playerStats.hp += 5
			playerStats.mp -= 4
			playerStats.ap -=1
			
