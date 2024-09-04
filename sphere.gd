extends RigidBody3D


#func _ready() -> void:
	#pass
var collided: bool = false

func _process(delta: float) -> void:
	if !collided:
		return
	linear_velocity = transform.basis.z * 2


func _on_body_shape_entered(body_rid: RID, body: Node, body_shape_index: int, local_shape_index: int) -> void:
	collided = true
