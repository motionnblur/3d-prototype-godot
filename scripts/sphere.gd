extends RigidBody3D


@export var speed: float
var collided: bool = false
var gotoPos = []
var leftPressed: bool = false
var currentPosIndis = 0;
var lock1: bool = false;

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Left_Click"):
		leftPressed = true
		
func _process(delta: float) -> void:
	if !collided:
		return

	var mouse_pos = get_viewport().get_mouse_position()
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
		if raycast_result.size() > 0 and raycast_result.collider.name != "sphere":
			leftPressed = false
			
			var pos = raycast_result.position
			pos.y = position.y
	
			gotoPos.append(pos)
	
	if currentPosIndis < gotoPos.size() && currentPosIndis != gotoPos.size():
		if gotoPos[currentPosIndis] != Vector3.ZERO && gotoPos[currentPosIndis] != transform.origin:
			transform.origin = transform.origin.move_toward(gotoPos[currentPosIndis], delta*2)
		else:
			if currentPosIndis <= gotoPos.size():
				currentPosIndis += 1





#########################################################################################
func _on_body_shape_entered(body_rid: RID, body: Node, body_shape_index: int, local_shape_index: int) -> void:
	collided = true
	
func _on_area_3d_area_entered(area: Area3D) -> void:
	area.queue_free()
	%ProgressBar.value += 5
	%Audio.play()
