extends Control

export(NodePath) onready var shell_game = get_node(shell_game) as Node

var auto_lose = false
var enemy: Object

func _init():
	visible = false

func _ready():
	$InputBlocker.visible = true


func _on_battle_finished():
#	Starts right after a battle has finished
	auto_lose = false
	$InputBlocker.visible = true
	$ShellGame.animation_player.play("Load")
	yield($ShellGame.animation_player,"animation_finished")
	
	$ShellGame.speed += rand_range(0.01,0.32)
	$ShellGame.start_cup_game()
