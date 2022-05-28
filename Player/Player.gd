#继承于KinematicBody2D
extends KinematicBody2D

#设置人物加速度=500，最大速度=80，滚动速度=80,摩擦减速度=500
export var Acceleration = 500
export var MaxSpeed = 80
export var RollSpeed = 80
export var Friction = 500

#创建角色状态
enum{
	MOVE,
	ROLL,
	ATTACK
}


onready var animationPlay = $AnimationPlayer
onready var animationTree = $AnimationTree
onready var animationState = $AnimationTree.get("parameters/playback")
onready var hitbox = $HitboxPivot/Hitbox

# 定义一个玩家移动的二维矢量
var velocity = Vector2.ZERO
var roll_vector = Vector2.DOWN


#定义初始state
var state = MOVE

#在游戏运行开始
func _ready():
	#在游戏运行开始时，将动画树状态激活
	animationTree.active = true	
	#攻击区域的方向等于roll_vector的方向
	hitbox.KnockBack_vector = roll_vector
	
#播放动画帧
func _process(delta):
	match state:
		MOVE:
			move_state(delta)
		ROLL:
			roll_state(delta)
		ATTACK:
			attack_state(delta)

#创建角色移动函数	
func move_state(delta):
	#角色移动矢量初始化
	var input_vector = Vector2.ZERO
	# 记录玩家输入的方向信号
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	#对矢量进行单位化
	input_vector = input_vector.normalized()
	
	#根据输入情况播放动画
	if input_vector != Vector2.ZERO:
		roll_vector = input_vector
		hitbox.KnockBack_vector = input_vector
		animationTree.set("parameters/Idle/blend_position", input_vector)
		animationTree.set("parameters/Run/blend_position", input_vector)
		animationTree.set("parameters/Attack/blend_position", input_vector)
		animationTree.set("parameters/Roll/blend_position", input_vector)
		animationState.travel("Run")
		velocity = velocity.move_toward(input_vector * MaxSpeed, Acceleration * delta)
	else:
		animationState.travel("Idle")
		velocity = velocity.move_toward(Vector2.ZERO, Friction * delta)
	
	#输入攻击指令后，移动矢量归零，切换成攻击状态
	if Input.is_action_just_pressed("attack"):
		velocity = Vector2.ZERO
		state = ATTACK
	
	if Input.is_action_just_pressed("roll"):
		velocity = Vector2.ZERO
		state = ROLL
		
	move()

#创建角色移动函数
func move():
	velocity = move_and_slide(velocity)	
	
#创建角色翻滚函数
func roll_state(delta):
	velocity = roll_vector * RollSpeed
	animationState.travel("Roll")
	move()
	


func attack_state(delta):
	animationState.travel("Attack")
	
#攻击动画停止后，角色状态进入MOVE状态	
func attack_animation_finished():
	state = MOVE
	
#滚动动画停止后，角色状态进入MOVE状态	
func roll_animation_finished():
	state = MOVE
	
