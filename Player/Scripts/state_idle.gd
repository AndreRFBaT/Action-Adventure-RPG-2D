class_name State_Idle extends State

@onready var walk_state: State = $"../Walk"
@onready var attack: State = $"../Attack"

func Enter() -> void:
	player.UpdateAnimation("idle")
	player.velocity = Vector2.ZERO

func Process(_delta: float) -> State:
	if player.direction != Vector2.ZERO:
		return walk_state
	return null 

func Physics(_delta: float) -> State:
	return null

func HandleInput(_event: InputEvent) -> State:
	if _event.is_action_pressed("attack"):
		return attack
	return null
