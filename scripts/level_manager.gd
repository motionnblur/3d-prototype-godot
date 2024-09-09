extends Node

@export var max_step: int

var current_step: int = 0
var label: Label
var label2: Label
var is_end: bool = false
var is_win: bool = false
var goals: int
var goal_counter: int = 0

func _ready() -> void:
	current_step = max_step
	
	label = get_node("/root/Node3D/UI/Label")
	label.text = str(max_step)
	label2 = get_node("/root/Node3D/UI/Label2")

func addStep() -> void:
	current_step -= 1
	
	if current_step > 0:
		label.text = str(current_step)
	else:
		label.text = "0"	
		is_end = true

func increaseGoalCount() -> void:
	goal_counter += 1
		
func end() -> void:
	if goal_counter == goals:
		print("win")
	elif is_end:
		await Global.delay(0.7)
		label2.show()
		await Global.delay(1.5)
		get_tree().reload_current_scene()
