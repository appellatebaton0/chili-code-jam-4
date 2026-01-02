class_name Kennel extends Area2D

@onready var kennels := get_kennels()
func get_kennels() -> Array[KennelCell]:
	var response:Array[KennelCell]
	
	for child in get_children():
		if child is KennelCell: response.append(child)
	
	return response

var mouse_over := false

func _mouse_enter() -> void: mouse_over = true
func _mouse_exit() -> void:  mouse_over = false

func _process(_delta: float) -> void:
	for kennel in kennels:
		kennel.position.y = lerp(kennel.position.y, -12.0 if (mouse_over or Input.is_action_pressed("U")) else 12.0, 0.2)
	
