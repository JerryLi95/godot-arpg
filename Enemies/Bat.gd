extends KinematicBody2D

var KnockBack = Vector2.ZERO 

const EnemyDeathEffect = preload("res://Scene/EnemyDeathEffect.tscn")

onready var stats = $Stats
onready var hurtbox = $Hurtbox

func _physics_process(delta):
	KnockBack = KnockBack.move_toward(Vector2.ZERO, 200 * delta)
	KnockBack = move_and_slide(KnockBack)

#击退蝙蝠效果
func bat_effect(node):
	stats.Health -= node.Damage
	print(stats.Health)
	KnockBack = node.KnockBack_vector * 100

#蝙蝠死亡效果	
func bat_destory():
	queue_free()
	var enemyDeathEffect = EnemyDeathEffect.instance()
	get_parent().add_child(enemyDeathEffect)
	enemyDeathEffect.global_position = global_position
	

func _ready():
	hurtbox.connect("area_entered", self, "bat_effect") 
	stats.connect("no_health", self, "bat_destory") 


	





