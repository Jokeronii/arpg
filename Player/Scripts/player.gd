class_name Player extends CharacterBody2D

#var cardinal, set ke down/south = (0,1)
var cardinal_direction:Vector2 = Vector2.DOWN
#nilai koordinat x,y
var direction : Vector2 = Vector2.ZERO

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var state_machine: PlayerStateMachine = $StateMachine

signal DirectionChanged(new_direction:Vector2)



# Called when the node enters the scene tree for the first time.
func _ready():
	state_machine.Initialize(self)
	pass # Replace with function body.

  
# Called every frame. 'delta' is the elapsed time since the previous frame.
	
func _process(delta):
	#direction.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	#direction.y = Input.get_action_strength("down") - Input.get_action_strength("up")
	direction = Vector2(
		Input.get_axis("left","right"),
		Input.get_axis("up","down")
	).normalized()
	pass
	
func _physics_process(delta):	
	move_and_slide()
	

func SetDirection() -> bool:
	var new_direction :Vector2 = cardinal_direction
	
	if direction == Vector2.ZERO:
		return false
	if direction.y == 0:
		#set new direction  to left
		new_direction = Vector2.LEFT if direction.x<0 else Vector2.RIGHT
	elif direction.x==0:
		new_direction = Vector2.UP if direction.y<0 else Vector2.DOWN
	
	if new_direction==cardinal_direction:
		return false
	cardinal_direction = new_direction
	DirectionChanged.emit(new_direction)
	sprite_2d.scale.x = -1 if cardinal_direction == Vector2.LEFT else 1
	return true

#cek state player



func UpdateAnimation(state:String)->void:
	animation_player.play(state + "_" + AnimDirection())
	pass

#cek arah directionPlayer
func AnimDirection()->String:
	if cardinal_direction == Vector2.DOWN:
		return "down"
	elif cardinal_direction == Vector2.UP:
		return "up"
	else:
		return "side"
