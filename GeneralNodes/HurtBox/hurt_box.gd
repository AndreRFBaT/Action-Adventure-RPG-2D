class_name HurtBox extends Area2D

@export var damage : int = 1

func _ready() -> void:
	area_entered.connect(AreaEntered)

func AreaEntered(a : Area2D) -> void:
	print("--- [HURTBOX DETECTED] ---")
	print("HurtBox belongs to: ", get_parent().name, " (Path: ", get_path(), ")")
	print("Area entered: ", a.name, " (Path: ", a.get_path(), ")")

	if a is HitBox:
		print(">> Object detected IS A HitBox!")
		print("HitBox belongs to: ", a.get_parent().name)

		# Lock 1 : belongs to the same parent
		if a.get_parent() == get_parent():
			print(">> BLOCKED: HurtBox and HitBox belongs to the same parent (", get_parent().name, ")")
			return

		# Lock 2 : belongs to the same owner (should be a Player)
		if owner != null and a.owner != null and a.owner == owner:
			print(">> BLOCKED: HurtBox and HitBox belongs to the same owner (", owner.name, ")")
			return

		print(">> DAMAGED! HurtBox belongs to: ", get_parent().name)
		a.TakeDamege(damage)
	else:
		print(">> The object detected is NOT a HitBox. Is a type: ", a.get_class())
	print("---------------------------")
