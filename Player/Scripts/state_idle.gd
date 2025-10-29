class_name State_Idle extends State

@onready var walk: State = $"../walk"
@onready var attack: State = $"../Attack"

#what happen when player enters this state
func Enter()->void:
	player.UpdateAnimation("idle")
	pass
	
#what happen when player exits this state
func Exit()->void:
	pass

#what happen during the _process update in this state
func Process(_delta:float)->State:
	if player.direction != Vector2.ZERO:
		return walk
	player.velocity = Vector2.ZERO
	return null
	
#what happen during the _physics update in this state
func Physics(_delta:float)->State:
	return null

#what happen with input events in this state
func HandleInput(_event:InputEvent)->State:
	if _event.is_action_pressed("attack"):
		return attack
	return null
