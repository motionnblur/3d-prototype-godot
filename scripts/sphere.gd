extends RigidBody3D


@export var speed: float

var camera: Camera3D
var cursor: MeshInstance3D

var collided: bool = false
var gotoPos = []
var leftClickPressed: bool = false
var currentPosIndis = 0;
var lock1: bool = false;
var mouse_pos: Vector2
var zoomAmount: float = 0.6
var zoomable: bool = false;
var _gotoPos: Vector3 = Vector3.ZERO
var camFirstPos: Vector3 = Vector3.ZERO


func _ready() -> void:
	camera = %Camera3D
	cursor = %Cursor
	camFirstPos = camera.transform.origin

func _input(event: InputEvent) -> void:
	mouse_pos = event.position
	if event.is_action_pressed("Left_Click"):
		leftClickPressed = true
		
		
func _process(delta: float) -> void:
	if !collided:
		return

	var ray_length = 100
	var from = camera.project_ray_origin(mouse_pos)
	var to = from + camera.project_ray_normal(mouse_pos) * ray_length
	var space = get_world_3d().direct_space_state
	var ray_query = PhysicsRayQueryParameters3D.new()
	ray_query.from = from
	ray_query.to = to
	ray_query.collide_with_areas = true
	var raycast_result = space.intersect_ray(ray_query)
	
	if leftClickPressed:
		if raycast_result and raycast_result.collider.name != "sphere":
			leftClickPressed = false
			
			var pos = raycast_result.position
			pos.y = position.y
	
			gotoPos.append(pos)
			cursor.show()
			cursor.position = Vector3(pos.x, 0.01, pos.z)
	
	if currentPosIndis < gotoPos.size() && currentPosIndis != gotoPos.size():
		if gotoPos[currentPosIndis] != Vector3.ZERO && gotoPos[currentPosIndis] != transform.origin:
			transform.origin = transform.origin.move_toward(gotoPos[currentPosIndis], delta * 2)
		else:
			if currentPosIndis <= gotoPos.size():
				currentPosIndis += 1
				if currentPosIndis == gotoPos.size():
					gotoPos.clear()
					currentPosIndis = 0
	


#########################################################################################
func _on_body_shape_entered(body_rid: RID, body: Node, body_shape_index: int, local_shape_index: int) -> void:
	collided = true
	
func _on_area_3d_area_entered(area: Area3D) -> void:
	area.queue_free()
	%ProgressBar.value += 5
	%Audio.play()
