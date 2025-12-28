class_name CatSaver extends Area2D

func _on_body_entered(body: Node2D) -> void:
	body.global_position = global_position
