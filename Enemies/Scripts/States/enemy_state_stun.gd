class_name EnemyStateStun extends EnemyState

@export var anim_name : String = "stun"
@export var knockback_speed : float = 200.0
@export var decelarate_speed : float = 10.0

@export_category("AI")
@export var next_idle_state : EnemyState

var _direction : Vector2
var _animation_finished : bool = false

func init() -> void:
	enemy.enemy_damaged.connect(_on_enemy_damaged)

func Enter() -> void:
	_animation_finished = false
	
	# Pega a direção inversa da movimentação atual para aplicar o knockback corretamente
	_direction = -enemy.cardinal_directions
	
	enemy.SetDirection(_direction)
	enemy.velocity = _direction * knockback_speed
	enemy.UpdateAnimation(anim_name)
	
	if not enemy.animation_player.animation_finished.is_connected(_on_enemy_finished):
		enemy.animation_player.animation_finished.connect(_on_enemy_finished)

func Exit() -> void:
	if enemy.animation_player.animation_finished.is_connected(_on_enemy_finished):
		enemy.animation_player.animation_finished.disconnect(_on_enemy_finished)

func Process(_delta : float) -> EnemyState:
	if _animation_finished:
		return next_idle_state
	# knockback redution 
	enemy.velocity = enemy.velocity.move_toward(Vector2.ZERO, decelarate_speed * 100.0 * _delta)
	#enemy.velocity = enemy.velocity * decelarate_speed * _delta
	return null

func Physics(_delta: float) -> EnemyState:
	return null

func _on_enemy_damaged() -> void:
	#print("!!! ENTRANDO EM STUN !!!")
	#print("Chamado por: ", get_stack())
	state_machine.ChangeState(self)

func _on_enemy_finished(_a : String) -> void:
	_animation_finished = true
