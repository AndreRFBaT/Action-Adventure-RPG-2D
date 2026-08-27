class_name State_Walk extends State

@export var move_speed : float = 100.0
@onready var idle_state: State = $"../Idle"

func Enter() -> void:
	player.UpdateAnimation("walk")

func Process(_delta: float) -> State:
	if player.direction == Vector2.ZERO:
		return idle_state
		
	if player.SetDirection():
		player.UpdateAnimation("walk")
		
	return null 

func Physics(_delta: float) -> State:
	# A velocidade é definida na física para o move_and_slide() colidir corretamente
	player.velocity = player.direction * move_speed
	return null

func HandleInput(_event: InputEvent) -> State:
	return null
