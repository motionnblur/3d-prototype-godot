extends RigidBody3D


#func _ready() -> void:
	#pass

func _process(delta: float) -> void:
	linear_velocity = transform.basis.z * 2;
