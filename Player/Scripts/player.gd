class_name Player extends CharacterBody2D

var cardinal_directions : Vector2 = Vector2.DOWN
const DIR_4 = [Vector2.RIGHT, Vector2.DOWN, Vector2.LEFT, Vector2.UP]
var direction : Vector2 = Vector2.ZERO
#var move_speed: float = 100.0
#var state : String = "idle"

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite: Sprite2D = $Sprite2D
@onready var state_machine: PlayerStateMachine = $StateMachine

signal DirectionChanged( new_direction: Vector2)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	PlayerManager.player = self
	state_machine.Initialize(self)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#direction.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	#direction.y = Input.get_action_strength("down") - Input.get_action_strength("up")
	direction = Vector2(
		Input.get_axis("left","right"),
		Input.get_axis("up", "down")
	).normalized()
	direction = direction.normalized()
	#velocity = direction * move_speed
	## Animation state for idle
	#if SetState() == true || SetDirection() == true:
		#UpdateAnimation()
	pass

func _physics_process (delta):
	move_and_slide()


func SetDirection() -> bool:
	if direction == Vector2.ZERO:
		return false

	var direction_id : int = int( round( ( direction + cardinal_directions * 0.1 ).angle() / TAU * DIR_4.size() ) )
	var new_direction = DIR_4[ direction_id ]

	# Previous direction soluction
	#if direction.y == 0:
		#new_direction = Vector2.LEFT if direction.x < 0 else Vector2.RIGHT
	#elif direction.x == 0:
		#new_direction = Vector2.UP if direction.y < 0 else Vector2.DOWN

	if new_direction == cardinal_directions:
		return false
	cardinal_directions = new_direction
	DirectionChanged.emit( new_direction )
	sprite.scale.x = -1 if cardinal_directions == Vector2.LEFT else 1
	return true


func UpdateAnimation(state: String) -> void:
	animation_player.play(state + "_" + AnimDirection())

	pass

func AnimDirection() -> String:
	if cardinal_directions == Vector2.DOWN:
		return "down"
	elif cardinal_directions == Vector2.UP:
		return "up"
	else:
		return "side"
