extends Node3D

var isRightClick: bool = false

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Right_Click"):
		isRightClick = true
	elif event.is_action_released("Right_Click"):
		isRightClick = false
	
	if event is InputEventMouseMotion:
		print(event.relative)

func _process(delta: float) -> void:
	if !isRightClick: return
	
	
