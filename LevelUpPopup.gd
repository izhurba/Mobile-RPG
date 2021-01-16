extends PopupPanel

const BattleUnits = preload("res://BattleUnits.tres")

var tempHP = 0  #+5
var tempAP = 0  #+1
var tempMP = 0  #+2

onready var hpCurLabel = $LevelUp/HPup/HPcur
onready var apCurLabel = $LevelUp/APup/APcur
onready var mpCurLabel = $LevelUp/MPup/MPcur
onready var spLabel = $LevelUp/SPLabel

func _ready():
	var player = BattleUnits.PlayerStats
	player.hp = player.max_hp
	player.ap = player.max_ap
	player.mp = player.max_mp
	hpCurLabel = player.max_hp
	apCurLabel = player.max_ap
	mpCurLabel = player.max_mp

func _on_incHP_pressed():
	var player = BattleUnits.PlayerStats
	hpCurLabel = "HP" + str(player.hp + 5)


func _on_incAP_pressed():
	var player = BattleUnits.PlayerStats
	apCurLabel = "AP" + str(player.ap + 1)

func _on_incMP_pressed():
	var player = BattleUnits.PlayerStats
	mpCurLabel = "MP" + str(player.mp + 2)

func _on_ResetButton_pressed():
	var player = BattleUnits.PlayerStats
	hpCurLabel = player.max_hp
	apCurLabel = player.max_ap
	mpCurLabel = player.max_mp


func _on_ConfirmButton_pressed():
	pass # Replace with function body.
