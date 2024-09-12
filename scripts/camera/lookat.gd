extends Node

var cam: Camera3D
var terrain: StaticBody3D

func _ready() -> void:
	cam = get_node("/root/Node3D/CamPivot/Camera3D")
	terrain = get_node("/root/Node3D/Terrain")

func _process(_delta: float) -> void:
	cam.look_at(terrain.transform.origin)
