extends Node

signal idle
signal run

var level_manager

var camera: Camera3D
var terrain: StaticBody3D
var mouse_pos: Vector2
var player: Node3D
var cursor: Node3D
var anim_player: AnimationPlayer
var currentPosIndis = 0;

var gotoPos = []
var leftClickPressed: bool = false
var drawStart: bool = false
var firstPlayerPos: Vector3

######################
var isDrawStarted: bool = false
var isPathModeActivated: bool = false
var isWalkingStarted: bool = false
######################

func _ready() -> void:
	level_manager = get_node("/root/Node3D/LevelManager")
	camera = get_node("/root/Node3D/CamPivot/Camera3D")
	terrain = get_node("/root/Node3D/Terrain")
	cursor = get_node("/root/Node3D/Cursor")
	player = get_parent().get_parent()
	anim_player = get_parent().get_parent().get_node("AnimationPlayer")
	
func _input(event: InputEvent) -> void:
	mouse_pos = event.position
	if event.is_action_pressed("Left_Click"):
		leftClickPressed = true
	elif event.is_action_released("Left_Click"):
		leftClickPressed = false

func _process(delta: float) -> void:
	if leftClickPressed && level_manager.current_step > 0:
		var mouseGroundPos: Vector3 = getMouseGroundPos()
		if isPathModeActivated:
			moveCursorWithPointer(mouseGroundPos)
			drawAllPastLines()
			drawLinesBetween(gotoPos[gotoPos.size()-1], mouseGroundPos)
			isDrawStarted = true
		else:
			moveCursorWithPointer(mouseGroundPos)
			drawLines(mouseGroundPos)
			isDrawStarted = true
	elif isDrawStarted:
		isPathModeActivated = true
		isDrawStarted = false
		
		gotoPos.append(getMouseGroundPos())
		level_manager.addStep()
		player.look_at(gotoPos[currentPosIndis], -Vector3.UP)
		run.emit()
	elif isPathModeActivated:
		isWalkingStarted = true
		var line_beginn = Vector3(firstPlayerPos.x, 0.1, firstPlayerPos.z)
		var line_endd = Vector3(gotoPos[0].x, 0.1, gotoPos[0].z)
		DebugDraw3D.draw_line(line_beginn, line_endd)
		for n in range(0, gotoPos.size()-1):
			var line_begin = Vector3(gotoPos[n].x, 0.1, gotoPos[n].z)
			var line_end = Vector3(gotoPos[n+1].x, 0.1, gotoPos[n+1].z)
			DebugDraw3D.draw_line(line_begin, line_end)
			
	if isWalkingStarted:
		if currentPosIndis >= gotoPos.size(): return
		if player.transform.origin != gotoPos[currentPosIndis]:
			player.transform.origin = player.transform.origin.move_toward(gotoPos[currentPosIndis], delta * 2)
		else:
			if currentPosIndis <= gotoPos.size():
				currentPosIndis += 1
				if currentPosIndis < gotoPos.size():
					player.look_at(gotoPos[currentPosIndis], -Vector3.UP)
				elif currentPosIndis == gotoPos.size():
					idle.emit()
					level_manager.isWin()
					
			
func moveCursorWithPointer(v: Vector3) -> void:
	cursor.position = v
func drawLines(v: Vector3) -> void:
	var line_begin = Vector3(player.transform.origin.x, 0.1, player.transform.origin.z)
	var line_end = Vector3(v.x, 0.1, v.z)
	DebugDraw3D.draw_line(line_begin, line_end)
func drawLinesBetween(v1: Vector3, v2: Vector3) -> void:
	var line_begin = Vector3(v1.x, 0.1, v1.z)
	var line_end = Vector3(v2.x, 0.1, v2.z)
	DebugDraw3D.draw_line(line_begin, line_end)
func drawAllPastLines() -> void:
	var line_beginn = Vector3(firstPlayerPos.x, 0.1, firstPlayerPos.z)
	var line_endd = Vector3(gotoPos[0].x, 0.1, gotoPos[0].z)
	DebugDraw3D.draw_line(line_beginn, line_endd)
	for n in range(0, gotoPos.size()-1):
		var line_begin = Vector3(gotoPos[n].x, 0.1, gotoPos[n].z)
		var line_end = Vector3(gotoPos[n+1].x, 0.1, gotoPos[n+1].z)
		DebugDraw3D.draw_line(line_begin, line_end)

func getMouseGroundPos() -> Vector3:
	var ray_length = 100
	var from = camera.project_ray_origin(mouse_pos)
	var to = from + camera.project_ray_normal(mouse_pos) * ray_length
	var space = player.get_world_3d().direct_space_state
	var ray_query = PhysicsRayQueryParameters3D.new()
	ray_query.from = from
	ray_query.to = to
	ray_query.collide_with_areas = true
	
	var raycast_result = space.intersect_ray(ray_query)
	if raycast_result and raycast_result.collider.name != "sphere":
		var pos = raycast_result.position
		pos.y = player.position.y
	
		return Vector3(pos.x, 0.01, pos.z)
	else:
		return Vector3.ZERO
