class_name Enemy extends CharacterBody2D

signal direction_change(new_direction : Vector2)
signal enemy_damaged()
signal enemy_destroyed()

const DIR_4 = [Vector2.RIGHT, Vector2.DOWN, Vector2.LEFT, Vector2.UP]

@export var hp: int = 3

var cardinal_directions : Vector2 = Vector2.DOWN
var direction : Vector2 = Vector2.ZERO
var player : Player
var invulnerable : bool = false

@onready var animation_player : AnimationPlayer = $AnimationPlayer
@onready var sprite : Sprite2D = $Sprite2D
@onready var hit_box : HitBox = $HitBox
@onready var state_machine : EnemyStateMachine = $EnemyStateMachine

func _ready() -> void:
	state_machine.initialize(self)
	player = PlayerManager.player
	hit_box.Damage.connect(_take_damage)

func _physics_process(_delta: float) -> void:
	move_and_slide()

func SetDirection(_new_direction : Vector2) -> bool:
	direction = _new_direction
	if direction == Vector2.ZERO:
		return false
	
	var direction_id : int = int(round(
		(direction + cardinal_directions * 0.1).angle() 
		/ TAU * DIR_4.size() 
	))
	var new_direction = DIR_4[direction_id]
	
	if new_direction == cardinal_directions:
		return false
	
	cardinal_directions = new_direction
	direction_change.emit(new_direction)
	sprite.scale.x = -1 if cardinal_directions == Vector2.LEFT else 1
	return true

func UpdateAnimation(state: String) -> void:
	# Trata animações sem direção específica (como stun ou destroy)
	if state == "stun" or state == "destroy":
		if animation_player.has_animation(state):
			animation_player.play(state)
			return
			
	# Para andar/idle, concatena com a direção
	animation_player.play(state + "_" + AnimDirection())

func AnimDirection() -> String:
	if cardinal_directions == Vector2.DOWN:
		return "down"
	elif cardinal_directions == Vector2.UP:
		return "up"
	else:
		return "side"

#func _take_damage(damage : int) -> void:
	#if invulnerable:
		#return
		#
	#hp -= damage
	#
	#if hp > 0:
		#enemy_damaged.emit()
	#else:
		#enemy_destroyed.emit()

func _take_damage(damage : int) -> void:
	# Trava 1: Se estiver invulnerável ou o dano for zero, ignora completamente
	if invulnerable or damage <= 0:
		return
		
	hp -= damage
	print("Dano recebido no Slime: ", damage, " | HP Restante: ", hp)
	
	if hp > 0:
		enemy_damaged.emit()
	else:
		if has_signal("enemy_destroyed"):
			emit_signal("enemy_destroyed")
