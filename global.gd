extends Node

func delay(val: float) -> void:
	await get_tree().create_timer(val).timeout
