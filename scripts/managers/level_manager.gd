extends Node

@export var max_step: int

signal win
signal lose

var move: Node
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
	
	move = get_node("/root/Node3D/Player/Scripts/Move")

func addStep() -> void:
	current_step -= 1
	
	if current_step > 0:
		label.text = str(current_step)
	else:
		label.text = "0"	
		is_end = true

func increaseGoalCount() -> void:
	goal_counter += 1
		
func isWin() -> void:
	if goal_counter == goals:
		win.emit()
		label2.text = "Win"
		await Global.delay(0.5)
		label2.show()
	elif is_end:
		lose.emit()
		await Global.delay(0.5)
		label2.show()
		await Global.delay(1.2)
		get_tree().reload_current_scene()
