extends Node

var camera: Camera3D
var terrain: StaticBody3D
var mouse_pos: Vector2
var player: RigidBody3D
var cursor: MeshInstance3D
var currentPosIndis = 0;

var gotoPos = []
var leftClickPressed: bool = false

func _ready() -> void:
	camera = get_node("/root/Node3D/CamPivot/Camera3D")
	terrain = get_node("/root/Node3D/Terrain")
	cursor = get_node("/root/Node3D/Cursor")
	player = get_parent().get_parent()
	
func _input(event: InputEvent) -> void:
	mouse_pos = event.position
	if event.is_action_pressed("Left_Click"):
		leftClickPressed = true

func _process(delta: float) -> void:
	var ray_length = 100
	var from = camera.project_ray_origin(mouse_pos)
	var to = from + camera.project_ray_normal(mouse_pos) * ray_length
	var space = player.get_world_3d().direct_space_state
	var ray_query = PhysicsRayQueryParameters3D.new()
	ray_query.from = from
	ray_query.to = to
	ray_query.collide_with_areas = true
	var raycast_result = space.intersect_ray(ray_query)
	
	if leftClickPressed:
		if raycast_result and raycast_result.collider.name != "sphere":
			leftClickPressed = false
			
			var pos = raycast_result.position
			pos.y = player.position.y
	
			gotoPos.append(pos)
			cursor.show()
			cursor.position = Vector3(pos.x, 0.01, pos.z)
	
	if currentPosIndis < gotoPos.size() && currentPosIndis != gotoPos.size():
		if gotoPos[currentPosIndis] != Vector3.ZERO && gotoPos[currentPosIndis] != player.transform.origin:
			player.transform.origin = player.transform.origin.move_toward(gotoPos[currentPosIndis], delta * 2)
		else:
			if currentPosIndis <= gotoPos.size():
				currentPosIndis += 1
				if currentPosIndis == gotoPos.size():
					gotoPos.clear()
					currentPosIndis = 0
