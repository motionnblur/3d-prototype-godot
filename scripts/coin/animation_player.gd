extends AnimationPlayer


func _ready() -> void:
	await Global.delay(randf())
	play("coin_anim")
