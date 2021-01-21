extends Node

const BattleUnits = preload("res://BattleUnits.tres")

export(Array, PackedScene) var enemies = []

onready var battleActionButtons = $UI/BattleActionButtons
onready var animationPlayer = $AnimationPlayer
onready var nextRoomButton = $UI/CenterContainer/NextRoomButton
onready var levelUpButton = $UI/CenterContainer/LevelUpButton
onready var enemyPosition = $EnemyPosition
onready var levelUpPopup = $LevelUpPopup
onready var restartButton = $Restart
onready var diedLabel = $DiedLabel
onready var fade2 = $Fade2Died

func _ready():
	randomize()
	diedLabel.hide()
	restartButton.hide()
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
	if playerStats.hp <= 0:
		_on_Player_died()
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
		if player.level % 5:
			player.damage += 2
		player.experience -= player.maxExp
		levelUpButton.show()
		yield(levelUpPopup, "levelUpDone")
		levelUpButton.hide()
		player.hp = player.max_hp
		player.ap = player.max_ap
		player.mp = player.max_mp
	nextRoomButton.show()
	battleActionButtons.hide()

func _on_Player_died():
	animationPlayer.play("FadeToDied")
	yield(animationPlayer,"animation_finished")
	diedLabel.show()
	restartButton.show()

func _on_NextRoomButton_pressed():
	nextRoomButton.hide()
	animationPlayer.play("FadeToNewRoom")
	yield(animationPlayer, "animation_finished")
	battleActionButtons.show()
	create_new_enemy()
	start_player_turn()


func _on_Restart_pressed():
	var player = BattleUnits.PlayerStats
	var enemy = BattleUnits.Enemy
	player.experience = 0
	enemy.take_damage(100)
	player.max_hp = 25
	player.max_ap = 3
	player.max_mp = 10
	player.experience = 0
	player.hp = player.max_hp
	player.ap = player.max_ap
	player.mp = player.max_mp
	player.level = 1
	player.damage = 5
	diedLabel.hide()
	restartButton.hide()
	animationPlayer.play_backwards("FadeToDied")
	yield(animationPlayer, "animation_finished")
	_on_NextRoomButton_pressed()
