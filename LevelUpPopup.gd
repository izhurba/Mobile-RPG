extends PopupPanel

const BattleUnits = preload("res://BattleUnits.tres")

var tempHP = 0  #+5
var tempAP = 0  #+1
var tempMP = 0  #+2
var tempSP = 2

onready var hpCurLabel = $LevelUp/HPup/HPcur
onready var apCurLabel = $LevelUp/APup/APcur
onready var mpCurLabel = $LevelUp/MPup/MPcur
onready var spLabel = $LevelUp/SPLabel

signal levelUpDone()

func _ready():
	var player = BattleUnits.PlayerStats
	tempHP = player.max_hp
	tempAP = player.max_ap
	tempMP = player.max_mp
	hpCurLabel.text = "HP" + str(player.max_hp)
	apCurLabel.text = "AP" + str(player.max_ap)
	mpCurLabel.text = "MP" + str(player.max_mp)

func _on_incHP_pressed():
	var player = BattleUnits.PlayerStats
	if tempSP >= 1:
		tempHP += 5
		hpCurLabel.text = "HP" + str(tempHP)
		tempSP -= 1
		spLabel.text = str(tempSP) + " Skill Points"
	else:
		pass

func _on_incAP_pressed():
	var player = BattleUnits.PlayerStats
	if tempSP >= 1:
		tempAP += 1
		apCurLabel.text = "AP" + str(tempAP)
		tempSP -= 1
		spLabel.text = str(tempSP) + " Skill Points"
	else:
		pass

func _on_incMP_pressed():
	var player = BattleUnits.PlayerStats
	if tempSP >= 1:
		tempMP += 2
		mpCurLabel.text = "MP" + str(tempMP)
		tempSP -= 1
		spLabel.text = str(tempSP) + " Skill Points"
	else:
		pass

func _on_ResetButton_pressed():
	var player = BattleUnits.PlayerStats
	tempSP = 2
	tempHP = player.max_hp
	tempAP = player.max_ap
	tempMP = player.max_mp
	spLabel.text = str(tempSP) + " Skill Points"
	hpCurLabel.text = "HP" + str(player.max_hp)
	apCurLabel.text = "AP" + str(player.max_ap)
	mpCurLabel.text = "MP" + str(player.max_mp)


func _on_ConfirmButton_pressed():
	var player = BattleUnits.PlayerStats
	player.max_hp = tempHP
	player.max_ap = tempAP
	player.max_mp = tempMP
	emit_signal("levelUpDone")
	self.hide()


func _on_LevelUpButton_pressed():
	popup()
	tempSP = 2
	#self.visible = true
