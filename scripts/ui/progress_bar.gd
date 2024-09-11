extends ProgressBar


var level_manager
var value_to_increase: float

func _ready() -> void:
	level_manager = get_node("/root/Node3D/LevelManager")
	value_to_increase = 100/level_manager.max_step

func _on_score_increase_bar() -> void:
	value += value_to_increase
