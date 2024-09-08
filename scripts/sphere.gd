extends RigidBody3D


@export var speed: float
var collided: bool = false
var gotoPos = []
var leftPressed: bool = false
var currentPosIndis = 0;
var lock1: bool = false;
var mouse_pos: Vector2
var zoomAmount: float = 0.6
var zoomable: bool = false;
var _gotoPos: Vector3 = Vector3.ZERO
var camFirstPos: Vector3 = Vector3.ZERO


func _ready() -> void:
	camFirstPos = %Camera3D.transform.origin

func _input(event: InputEvent) -> void:
	mouse_pos = event.position
	if event.is_action_pressed("Left_Click"):
		leftPressed = true
	elif event.is_action_pressed("Wheel_Up"):
		zoomable = true
		
		zoomAmount = 0.6
		var zoomDirection: Vector3 = (%Terrain.transform.origin - %Camera3D.transform.origin).normalized()
		
		var dist = %Camera3D.transform.origin.distance_to(%Terrain.transform.origin)
		if dist > 5:
			_gotoPos = %Camera3D.transform.origin + zoomDirection * zoomAmount
		#_gotoPos = clamp(_gotoPos, %Camera3D.transform.origin + zoomDirection * 3.5, %Camera3D.transform.origin + zoomDirection * -3.5)
	elif event.is_action_pressed("Wheel_Down"):
		zoomable = true
		
		zoomAmount = -0.6
		var zoomDirection: Vector3 = (%Terrain.transform.origin - %Camera3D.transform.origin).normalized()
		
		var dist = %Camera3D.transform.origin.distance_to(%Terrain.transform.origin)
		if dist < 10:
			_gotoPos = %Camera3D.transform.origin + zoomDirection * zoomAmount
		#_gotoPos = clamp(_gotoPos, %Camera3D.transform.origin + zoomDirection * 3.5, %Camera3D.transform.origin + zoomDirection * -1.5)
		
func _process(delta: float) -> void:
	if !collided:
		return

	var ray_length = 100
	var from = %Camera3D.project_ray_origin(mouse_pos)
	var to = from + %Camera3D.project_ray_normal(mouse_pos) * ray_length
	var space = get_world_3d().direct_space_state
	var ray_query = PhysicsRayQueryParameters3D.new()
	ray_query.from = from
	ray_query.to = to
	ray_query.collide_with_areas = true
	var raycast_result = space.intersect_ray(ray_query)
	
	if leftPressed:
		if raycast_result and raycast_result.collider.name != "sphere":
			leftPressed = false
			
			var pos = raycast_result.position
			pos.y = position.y
	
			gotoPos.append(pos)
			%Cursor.show()
			%Cursor.position = Vector3(pos.x, 0.01, pos.z)
	
	if currentPosIndis < gotoPos.size() && currentPosIndis != gotoPos.size():
		if gotoPos[currentPosIndis] != Vector3.ZERO && gotoPos[currentPosIndis] != transform.origin:
			transform.origin = transform.origin.move_toward(gotoPos[currentPosIndis], delta * 2)
		else:
			if currentPosIndis <= gotoPos.size():
				currentPosIndis += 1
				if currentPosIndis == gotoPos.size():
					gotoPos.clear()
					currentPosIndis = 0
	
	if zoomable:
		if %Camera3D.transform.origin != _gotoPos:
			%Camera3D.transform.origin = %Camera3D.transform.origin.move_toward(_gotoPos, delta * 2)
		else:
			zoomable = false




#########################################################################################
func _on_body_shape_entered(body_rid: RID, body: Node, body_shape_index: int, local_shape_index: int) -> void:
	collided = true
	
func _on_area_3d_area_entered(area: Area3D) -> void:
	area.queue_free()
	%ProgressBar.value += 5
	%Audio.play()
