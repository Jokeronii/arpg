class_name State extends Node

#stores a reference to the player
static var player: Player

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

#what happen when player enters this state
func Enter()->void:
	pass
	
#what happen when player exits this state
func Exit()->void:
	pass

#what happen during the _process update in this state
func Process(_delta:float)->State:
	return null
	
#what happen during the _physics update in this state
func Physics(_delta:float)->State:
	return null

#what happen with input events in this state
func HandleInput(_event:InputEvent)->State:
	return null
