extends RigidBody3D


@export var speed: float
var collided: bool = false
		
func _process(delta: float) -> void:
	if !collided:
		return
		
	if Input.is_action_pressed("KEY_W"):
		position -= global_basis.z * speed * delta
	elif Input.is_action_pressed("KEY_S"):
		position += global_basis.z * speed * delta
	elif Input.is_action_pressed("KEY_A"):
		position -= global_basis.x * speed * delta
	elif Input.is_action_pressed("KEY_D"):
		position += global_basis.x * speed * delta


func _on_body_shape_entered(body_rid: RID, body: Node, body_shape_index: int, local_shape_index: int) -> void:
	collided = true
