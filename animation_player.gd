extends AnimationPlayer


func _ready() -> void:
	await get_tree().create_timer(randf()).timeout
	play("coin_anim")
