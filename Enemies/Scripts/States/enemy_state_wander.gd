class_name EnemyStateWander extends EnemyState

## Store a reference to the enemy that this state belongs to
@export var anim_name : String = "walk"
@export var wander_speed : float = 20.0


@export_category("AI")
@export var state_animation_duration : float = 0.5
#@export var state_duration_max : float = 1.5
@export var state_cycles_min : int = 1
@export var state_cycles_max : int = 3
@export var next_idle_state : EnemyState

var _timer : float = 0.0
var _direction : Vector2

func _init() -> void:
	pass

# Called when the node enters the scene tree for the first time.
#func _ready() -> void:
	#pass # Replace with function body.

# What happens when the player enters this State?
#func Enter() -> void:
	#_timer = randi_range( state_cycles_min, state_cycles_max ) * state_animation_duration
	#var rand = randi_range( 0, 3 )
	#_direction = enemy.DIR_4[ rand ]
	#enemy.velocity = _direction * wander_speed
	#enemy.SetDirection( _direction )
	#enemy.UpdateAnimation( anim_name )
	#pass
func Enter() -> void:
	_timer = randi_range(state_cycles_min, state_cycles_max) * state_animation_duration
	var rand = randi_range(0, 3)
	_direction = enemy.DIR_4[rand]
	enemy.velocity = _direction * wander_speed
	enemy.SetDirection(_direction)
	
	print("Wander acionado | Anim: ", anim_name, " | Direção: ", _direction)
	enemy.UpdateAnimation(anim_name)

# What happens when the player exits this State?
func Exit() -> void:
	pass

# what happens during the _process uodate in this State?
func Process(_delta : float) -> EnemyState:
	_timer -= _delta
	if _timer < 0:
		return next_idle_state
	return null

# What happens during the _physics_process update in this State?
func Physics (_delta: float) -> EnemyState:
	return null
