extends RigidBody3D


@export var speed: float
var collided: bool = false
		
func _process(delta: float) -> void:
	if !collided:
		return
	#%ProgressBar.value += delta*3
		
	#if Input.is_action_pressed("KEY_W"):
		#position -= global_basis.z * speed * delta
	#elif Input.is_action_pressed("KEY_S"):
		#position += global_basis.z * speed * delta
	#elif Input.is_action_pressed("KEY_A"):
		#position -= global_basis.x * speed * delta
	#elif Input.is_action_pressed("KEY_D"):
		#position += global_basis.x * speed * delta
		
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
	
	if raycast_result.size() > 0 and raycast_result.collider.name != "sphere":
		var pos = raycast_result.position
		pos.y = position.y
		var dir = (pos - position).normalized()
		position += dir*delta


func _on_body_shape_entered(body_rid: RID, body: Node, body_shape_index: int, local_shape_index: int) -> void:
	collided = true


func _on_area_3d_area_entered(area: Area3D) -> void:
	print("area entered")
