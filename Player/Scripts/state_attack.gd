class_name State_Attack extends State

var attacking : bool = false
@export var attack_sound : AudioStream
@export_range(1,20,0.5) var decelarate_speed : float = 5.0

@onready var animation_player: AnimationPlayer = $"../../AnimationPlayer"
@onready var attack_animation: AnimationPlayer = $"../../Sprite2D/AttackEffectSprite/AnimationPlayer"
@onready var audio_attack: AudioStreamPlayer2D = $"../../Audio/AudioStreamPlayer2D"

@onready var idle: State = $"../Idle"
@onready var walk_state: State = $"../Walk"
@onready var hurt_box: HurtBox = %AttackHurtBox


func Enter() -> void:
	player.UpdateAnimation("attack")
	attack_animation.play("attack_" + player.AnimDirection())
	animation_player.animation_finished.connect(EndAttack)
	audio_attack.stream = attack_sound
	audio_attack.pitch_scale = randf_range(0.9 , 1.1)
	audio_attack.play()
	attacking = true
	# Reset velocity
	#player.velocity = Vector2.ZERO
	await get_tree().create_timer(0.075).timeout
	hurt_box.monitoring = true

func Exit() -> void:
	animation_player.animation_finished.disconnect(EndAttack)
	attacking = false
	hurt_box.monitoring = false

func Process(_delta: float) -> State:
	#player.direction != Vector2.ZERO
	#player.velocity != Vector2.ZERO
	player.velocity -= player.velocity * decelarate_speed * _delta
	
	
	if attacking == false:
		if player.direction == Vector2.ZERO:
			return idle
		else :
			return walk_state
	return null 

func Physics(_delta: float) -> State:
	# Keep velocity to ZERO while attacking
	#player.velocity = Vector2.ZERO
	return null

func HandleInput(_event: InputEvent) -> State:
	return null

func EndAttack( _newAnimName : String) -> void:
	attacking = false
