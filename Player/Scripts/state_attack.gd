class_name State_Attack extends State

var attacking:bool = false

@export var attack_sound:AudioStream
@export_range(1,20,0.5) var decelerate_speed:float = 5.0

@onready var animation_player: AnimationPlayer = $"../../AnimationPlayer"
@onready var walk: State = $"../walk"
@onready var idle: State_Idle = $"../idle"
@onready var attack_anim: AnimationPlayer = $"../../Sprite2D/AttackEffectSprite/AnimationPlayer"
@onready var audio: AudioStreamPlayer2D = $"../../Audio/AudioStreamPlayer2D"
@onready var hurt_box: HurtBox = $"../../Interactions/HurtBox"

#what happen when player enters this state
func Enter()->void:
	player.UpdateAnimation("attack")
	animation_player.animation_finished.connect(EndAttack)
	attack_anim.play("attack_" + player.AnimDirection())
	audio.stream = attack_sound
	audio.pitch_scale = randf_range(0.9,1.1)
	audio.play()
	attacking = true
	await get_tree().create_timer(0.075).timeout
	
	hurt_box.monitoring = true
	pass
	
#what happen when player exits this state
func Exit()->void:
	animation_player.animation_finished.disconnect(EndAttack)
	attacking = false
	hurt_box.monitoring = false
	pass

#what happen during the _process update in this state
func Process(_delta:float)->State:
	#player.velocity = Vector2.ZERO
	player.velocity -= player.velocity * decelerate_speed * _delta
	
	if attacking == false:
		if player.direction == Vector2.ZERO:
			return idle
		else:
			return walk
	return null
	
#what happen during the _physics update in this state
func Physics(_delta:float)->State:
	return null

#what happen with input events in this state
func HandleInput(_event:InputEvent)->State:
	return null
	
func EndAttack(_newAnimName:String)->void:
	attacking = false 
