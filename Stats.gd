extends Node

#export 可以将后面的变量放到面板中设置
export(int) var MaxHealth = 1
onready var Health = MaxHealth setget set_health

signal no_health

func set_health(value):
	Health = value
	
	if Health <= 0:
		emit_signal("no_health")
		print("Health=0")
