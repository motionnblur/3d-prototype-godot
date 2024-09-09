extends Node

var level_manager

var camera: Camera3D
var terrain: StaticBody3D
var mouse_pos: Vector2
var player: Node3D
var cursor: MeshInstance3D
var currentPosIndis = 0;

var gotoPos = []
var leftClickPressed: bool = false
var drawStart: bool = false
var firstPlayerPos: Vector3

func _ready() -> void:
	level_manager = get_node("/root/Node3D/LevelManager")
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
	
	if leftClickPressed && level_manager.current_step > 0:
		if raycast_result and raycast_result.collider.name != "sphere":
			leftClickPressed = false
			
			var pos = raycast_result.position
			pos.y = player.position.y
	
			if gotoPos.size() == 0:
				gotoPos.append(player.transform.origin) 
			gotoPos.append(pos)
			drawStart = true
			cursor.show()
			cursor.position = Vector3(pos.x, 0.01, pos.z)
			level_manager.addStep()
	
	if currentPosIndis < gotoPos.size() && currentPosIndis != gotoPos.size():
		if gotoPos[currentPosIndis] != Vector3.ZERO && gotoPos[currentPosIndis] != player.transform.origin:
			player.transform.origin = player.transform.origin.move_toward(gotoPos[currentPosIndis], delta * 2)
		else:
			if currentPosIndis <= gotoPos.size():
				currentPosIndis += 1
				if currentPosIndis == gotoPos.size():
					gotoPos.clear()
					currentPosIndis = 0
					level_manager.end()

	if drawStart && gotoPos.size() > 0:
		for n in range(0, gotoPos.size()-1):
			var line_begin2 = Vector3(gotoPos[n].x, 0.1, gotoPos[n].z)
			var line_end2 = Vector3(gotoPos[n+1].x, 0.1, gotoPos[n+1].z)
			DebugDraw3D.draw_line(line_begin2, line_end2)
