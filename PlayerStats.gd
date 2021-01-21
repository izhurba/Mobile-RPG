extends Node

const BattleUnits = preload("res://BattleUnits.tres")

var max_hp = 25 setget set_max_hp
var hp = max_hp setget set_hp
var max_ap = 3 setget set_max_ap
var ap = max_ap setget set_ap
var max_mp = 10 setget set_max_mp
var mp = max_mp setget set_mp
var damage = 5 setget set_damage
var level = 1 setget set_lvl
var experience = 0 setget set_exp
var maxExp = 25 setget set_max_exp
var skillPoints = 0 setget set_sp

signal hp_changed(value)
signal ap_changed(value)
signal mp_changed(value)
signal lvl_changed(value)
signal exp_changed(value)
signal sp_changed(value)
signal died
signal end_turn

func set_hp(value):
	hp = clamp(value, 0, max_hp)
	emit_signal("hp_changed", hp)
	if hp <= 0:
		emit_signal("died")

func set_max_hp(value):
	max_hp = value

func set_ap(value):
	ap = clamp(value, 0, max_ap)
	emit_signal("ap_changed", ap)
	if ap == 0:
		emit_signal("end_turn")

func set_max_ap(value):
	max_ap = value

func set_mp(value):
	mp = clamp(value, 0, max_mp)
	emit_signal("mp_changed", mp)

func set_max_mp(value):
	max_mp = value

func set_damage(value):
	damage = value

func set_exp(value):
	experience = value
	emit_signal("exp_changed", experience)

func set_max_exp(value):
	maxExp = value
	

func set_lvl(value):
	level = value
	emit_signal("lvl_changed", level)

func set_sp(value):
	skillPoints = value
	emit_signal("sp_changed", skillPoints)

func _ready():
	BattleUnits.PlayerStats = self

func _exit_tree():
	BattleUnits.PlayerStats = null
