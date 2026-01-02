class_name Bathtub extends Area2D

@export var clean_speed := 3

var clean_time := 0.0

var currently_cleaning:Array[Cat]

func _process(delta: float) -> void:
	
	if clean_time >= 1.0:
		
		for cat in currently_cleaning:
			if Mouse.holding == cat: continue
			
			cat.data.change_cleanliness(clean_speed)
		
		clean_time = 0.0
	clean_time = move_toward(clean_time, 1.0, delta)

func _on_body_entered(body: Node2D) -> void:
	if body is Cat:
		currently_cleaning.append(body)
		body.cleaning.emitting = true
		
	body.z_index -= 1
func _on_body_exited(body: Node2D) -> void:
	if body is Cat:
		currently_cleaning.erase(body)
		body.cleaning.emitting = false
		
	body.z_index += 1
