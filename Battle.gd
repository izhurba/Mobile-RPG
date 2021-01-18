extends Node

const BattleUnits = preload("res://BattleUnits.tres")

export(Array, PackedScene) var enemies = []

onready var battleActionButtons = $UI/BattleActionButtons
onready var damageButton = $UI/BattleActionButtons/SwordActionButton/HoverInfo
onready var animationPlayer = $AnimationPlayer
onready var nextRoomButton = $UI/CenterContainer/NextRoomButton
onready var levelUpButton = $UI/CenterContainer/LevelUpButton
onready var enemyPosition = $EnemyPosition
onready var levelUpPopup = $LevelUpPopup

func _ready():
	randomize()
	nextRoomButton.hide()
	levelUpButton.hide()
	start_player_turn()
	var enemy = BattleUnits.Enemy
	if enemy != null:
		enemy.connect("died", self, "_on_Enemy_died")

func start_enemy_turn():
	battleActionButtons.hide()
	var enemy = BattleUnits.Enemy
	if enemy != null and not enemy.is_queued_for_deletion():
		enemy.attack()
		yield(enemy, "end_turn")
	start_player_turn()


func start_player_turn():
	battleActionButtons.show()
	var playerStats = BattleUnits.PlayerStats
	playerStats.ap = playerStats.max_ap
	yield(playerStats, "end_turn")
	start_enemy_turn()

func create_new_enemy():
	enemies.shuffle()
	var Enemy = enemies.front()
	var enemy = Enemy.instance()
	enemyPosition.add_child(enemy)
	enemy.connect("died", self, "_on_Enemy_died")

func _on_Enemy_died():
	var enemy = BattleUnits.Enemy
	var player = BattleUnits.PlayerStats
	player.experience += enemy.expVal
	if player.experience >= player.maxExp:
		levelUpPopup.spLabel.text = "2 Skill Points"
		player.level += 1
		player.experience -= player.maxExp
		levelUpButton.show()
		yield(levelUpPopup, "levelUpDone")
		levelUpButton.hide()
		player.hp = player.max_hp
		player.ap = player.max_ap
		player.mp = player.max_mp
	nextRoomButton.show()
	battleActionButtons.hide()

func _on_NextRoomButton_pressed():
	nextRoomButton.hide()
	animationPlayer.play("FadeToNewRoom")
	yield(animationPlayer, "animation_finished")
	battleActionButtons.show()
	create_new_enemy()
	start_player_turn()
