extends "res://Actions/ActionButton.gd"

const Slash = preload("res://Slash.tscn")

onready var info = $HoverInfo

func _ready():
	var player = BattleUnits.PlayerStats
	info.description = "Deals " + str(player.damage) + " damage"

func _on_pressed():
	var enemy = BattleUnits.Enemy
	var playerStats = BattleUnits.PlayerStats
	if enemy != null and playerStats != null:
		create_slash(enemy.global_position)
		enemy.take_damage(playerStats.damage)
		playerStats.mp += 2
		playerStats.ap -= 1

func create_slash(position):
	var slash = Slash.instance()
	var main = get_tree().current_scene
	main.add_child(slash)
	slash.global_position = position
