extends Node

@export var max_step: int

var current_step: int = 0
var label: Label

func _ready() -> void:
	current_step = max_step
	
	label = get_node("/root/Node3D/UI/Label")
	label.text = str(max_step)

func addStep() -> void:
	current_step -= 1
	
	if current_step > 0:
		label.text = str(current_step)
	else:
		label.text = "0"
		await Global.delay(0.7)
		print("Game End")
