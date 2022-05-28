extends AnimatedSprite


func _ready():
	#设置动画到第一帧
	frame = 0
	#对animatedSprite节点使用play方法播放动画
	play("Animation")
	#通过代码接收信号，在animatedSprite节点的动画播放后，使用destroyGrass函数
	connect("animation_finished", self, "on_animation_finished")

func on_animation_finished():
	queue_free()

#func _ready():
#	animatedSprite.frame = 0
#	animatedSprite.play("DestroyGrass")
#
#第二种使用信号的方式，通过信号面板设置
#func _on_AnimatedSprite_animation_finished():
#	queue_free()
