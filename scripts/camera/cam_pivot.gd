extends Node3D

var isRightClick: bool = false
var deltaMouse: Vector2
var mousePos1: Vector2
var mousePos2: Vector2
var posPhase: int = 1

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Right_Click"):
		isRightClick = true
	elif event.is_action_released("Right_Click"):
		isRightClick = false
	
	if event is InputEventMouseMotion:
		deltaMouse = event.relative

func _process(delta: float) -> void:
	if !isRightClick: return
	if !isDragging(): return
	
	var xRot = rotation_degrees.x - deltaMouse.y * delta * 8
	var yRot = rotation_degrees.y - deltaMouse.x * delta * 8
	
	xRot = clamp(xRot, -20, 20)
	#yRot = clamp(yRot, 0, 90)
	
	rotation_degrees = Vector3(xRot, yRot, rotation_degrees.z)

func isDragging() -> bool:
	var m_pos = get_viewport().get_mouse_position()
	if posPhase == 1:
		mousePos1 = m_pos
		posPhase = 2
	elif posPhase == 2:
		mousePos2 = m_pos
		posPhase = 1
	
	if mousePos1 == mousePos2:
		return false
	else:
		return true
