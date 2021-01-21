extends "res://Actions/ActionButton.gd"

const Slash = preload("res://Slash.tscn")

onready var info = $HoverInfo

func _ready():
	var player = BattleUnits.PlayerStats
	info.description = "Deals " + str(2*player.damage) + " damage\n" + "Cost: 4 mp and 2 ap" 

func _on_pressed():
	var enemy = BattleUnits.Enemy
	var playerStats = BattleUnits.PlayerStats
	if enemy != null and playerStats != null and playerStats.ap >= 2:
		create_slash(enemy.global_position)
		enemy.take_damage(2*playerStats.damage)
		playerStats.mp -= 4
		playerStats.ap -= 2

func create_slash(position):
	var slash = Slash.instance()
	var main = get_tree().current_scene
	main.add_child(slash)
	slash.global_position = position
