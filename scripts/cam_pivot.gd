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
	
	var rotateX = -deltaMouse.y*delta*0.2
	var rotateY = -deltaMouse.x*delta*0.2
	var clmpX = clamp(global_rotation.x, 0, 0.6)
	var clmpY = clamp(global_rotation.y, 0, 0.6)
	
	rotate(Vector3(clmpX, clmpY, 0))
