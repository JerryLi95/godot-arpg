extends Node2D

onready var hurtBox = $Hurtbox


#创建草木破坏效果函数
func creat_grass_effect():
	#获取草木破坏效果的路径
		var GrassEffect = load("res://Scene/GrassEffect.tscn")   
		#将草木场景实例化
		var grassEffect = GrassEffect.instance()
		#获取场景的主场景
		var world = get_tree().current_scene
		#在主场景下增加子节点grassEffect
		world.add_child(grassEffect) 
		#把子节点grassEffect的全局坐标设置为Grass的全局坐标
		grassEffect.global_position = global_position
		#释放（删除）本节点
#		queue_free()
	
#func _process(delta):
#	if Input.is_action_just_pressed("attack"):
#		#获取草木破坏效果的路径
#		var GrassEffect = load("res://Scene/GrassEffect.tscn")   
#		#将草木场景实例化
#		var grassEffect = GrassEffect.instance()
#		#获取场景的主场景
#		var world = get_tree().current_scene
#		#在主场景下增加子节点grassEffect
#		world.add_child(grassEffect) 
#		#把子节点grassEffect的全局坐标设置为Grass的全局坐标
#		grassEffect.global_position = global_position
#		#释放（删除）本节点
#		queue_free()

func _ready():
	hurtBox.connect("area_entered",self,"destroyGrass")


func destroyGrass(node):
	creat_grass_effect()
	queue_free()



#func _on_Hurtbox_area_entered(area):
#	creat_grass_effect()
#	queue_free()
