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
	
	var xRot = rotation_degrees.x - deltaMouse.y * delta * 8
	var yRot = rotation_degrees.y - deltaMouse.x * delta * 8
	
	xRot = clamp(xRot, -20, 20)
	#yRot = clamp(yRot, 0, 90)
	
	rotation_degrees = Vector3(xRot, yRot, rotation_degrees.z)
