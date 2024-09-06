extends Node3D

var isRightClick: bool = false
var deltaMouse: Vector2

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Right_Click"):
		isRightClick = true
	elif event.is_action_released("Right_Click"):
		isRightClick = false
	
	if event is InputEventMouseMotion:
		deltaMouse = event.relative

func _process(delta: float) -> void:
	if !isRightClick: return
	
	rotate_x(-deltaMouse.y*delta*0.2)
	rotate_y(-deltaMouse.x*delta*0.2)
	
	print(global_rotation)
