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
	
	var rotateX = -deltaMouse.y*delta*0.02
	firstRot.x += rotateX
	
	var rotateY = -deltaMouse.x*delta*0.02
	firstRot.y += rotateY
	
	var clmpX = clamp(firstRot.x, 0, 0.6)
	var clmpY = clamp(firstRot.y, 0, 0.6)
	
	rotate_x(clmpX)
	rotate_y(clmpY)
