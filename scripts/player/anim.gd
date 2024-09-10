extends Node

var anim_player: AnimationPlayer

func _ready() -> void:
	anim_player = get_parent().get_parent().get_node("AnimationPlayer")


func _on_level_manager_win() -> void:
	anim_player.play("CharacterArmature|Duck")

func _on_level_manager_lose() -> void:
	anim_player.play("CharacterArmature|Death")

func _on_move_idle() -> void:
	anim_player.play("CharacterArmature|Idle")

func _on_move_run() -> void:
	anim_player.play("CharacterArmature|Run")
