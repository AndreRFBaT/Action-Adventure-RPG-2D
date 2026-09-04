class_name EnemyState extends Node

## Store a reference to the enemy that this state belongs to
var enemy : Enemy
var state_machine : EnemyStateMachine


func init() -> void:
	pass

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# What happens when the player enters this State?
func Enter() -> void:
	pass

# What happens when the player exits this State?
func Exit() -> void:
	pass

# what happens during the _process uodate in this State?
func Process(_delta : float) -> EnemyState:
	return null 

# What happens during the _physics_process update in this State?
func Physics (_delta: float) -> EnemyState:
	return null
