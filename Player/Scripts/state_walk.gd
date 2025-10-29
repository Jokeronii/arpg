class_name State_Walk extends State

@export var move_speed :float =100.0
@onready var idle: State = $"../idle"
@onready var attack: State_Attack = $"../Attack"



#what happen when player enters this state
func Enter()->void:
	player.UpdateAnimation("walk")
	pass
	
#what happen when player exits this state
func Exit()->void:
	pass

#what happen during the _process update in this state
func Process(_delta:float)->State:
	if player.direction == Vector2.ZERO:
		return idle

	#jika !== ZERO atau punya velocity, set arah + ubah ke walk
	player.velocity = player.direction * move_speed
	if player.SetDirection():
		player.UpdateAnimation("walk")
	return null
	
#what happen during the _physics update in this state
func Physics(_delta:float)->State:
	return null

#what happen with input events in this state
func HandleInput(_event:InputEvent)->State:
	if _event.is_action_pressed("attack"):
		return attack
	return null
