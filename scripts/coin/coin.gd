extends Area3D


var level_manager

func _ready() -> void:
	level_manager = get_node("/root/Node3D/LevelManager")
	level_manager.goals += 1
