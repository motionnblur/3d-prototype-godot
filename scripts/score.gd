extends Node

var progress_bar: ProgressBar
var audio: AudioStreamPlayer

func _ready() -> void:
	progress_bar = get_node("/root/Node3D/ProgressBar")
	audio = get_node("/root/Node3D/Audio")

func _on_area_3d_area_entered(area: Area3D) -> void:
	area.queue_free()
	progress_bar.value += 5
	audio.play()
