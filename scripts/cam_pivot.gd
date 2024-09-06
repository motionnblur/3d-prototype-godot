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
	
	var firstRot = global_rotation
	
	var rotateX = -deltaMouse.x*delta*0.1
	firstRot.x += rotateX
	
	var rotateY = -deltaMouse.y*delta*0.1
	firstRot.y += rotateY
	
	var clmpX = clamp(firstRot.x, 0, 0.6)
	var clmpY = clamp(firstRot.y, 0, 0.6)
	
	#rotate_y(clmpX)
	rotate_x(clmpY)
