class_name EnemyStateIdle extends EnemyState

## Store a reference to the enemy that this state belongs to
@export var anim_name : String = "idle"

@export_category("AI")
@export var state_duration_min : float = 0.5
@export var state_duration_max : float = 1.5
@export var after_idle_state : EnemyState

var _timer : float = 0.0


func _init() -> void:
	pass

# Called when the node enters the scene tree for the first time.
#func _ready() -> void:
	#pass # Replace with function body.

# What happens when the player enters this State?
func Enter() -> void:
	enemy.velocity = Vector2.ZERO
	_timer = randf_range( state_duration_min, state_duration_max )
	enemy.UpdateAnimation( anim_name )
	
	pass

# What happens when the player exits this State?
func Exit() -> void:
	pass

# what happens during the _process uodate in this State?
func Process(_delta : float) -> EnemyState:
	_timer -= _delta
	if _timer <= 0:
		return after_idle_state
	return null

# What happens during the _physics_process update in this State?
func Physics (_delta: float) -> EnemyState:
	return null
