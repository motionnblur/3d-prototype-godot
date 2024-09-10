extends Node

var camera: Camera3D
var terrain: StaticBody3D
var _gotoPos: Vector3 = Vector3.ZERO
var zoomAmount: float = 0.6
var zoomable: bool = false

func _ready() -> void:
	camera = get_node("/root/Node3D/CamPivot/Camera3D")
	terrain = get_node("/root/Node3D/Terrain")

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Wheel_Up"):
		zoomable = true
		
		var zoomDirection: Vector3 = (terrain.transform.origin - camera.transform.origin).normalized()
		var dist = camera.transform.origin.distance_to(terrain.transform.origin)
		
		if dist > 5:
			_gotoPos = camera.transform.origin + zoomDirection * zoomAmount
			
	elif event.is_action_pressed("Wheel_Down"):
		zoomable = true
		
		var zoomDirection: Vector3 = (terrain.transform.origin - camera.transform.origin).normalized()
		var dist = camera.transform.origin.distance_to(terrain.transform.origin)
		
		if dist < 10:
			_gotoPos = camera.transform.origin + zoomDirection * -zoomAmount

func _process(delta: float) -> void:
	if zoomable:
		if camera.transform.origin != _gotoPos:
			camera.transform.origin = camera.transform.origin.move_toward(_gotoPos, delta * 2)
		else:
			zoomable = false
