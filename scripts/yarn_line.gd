class_name YarnLine extends Line2D

var global_line_points:Array[Vector2]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if get_point_count() > 0:
		for i in range(get_point_count()):
			set_point_position(i, to_local(global_line_points[i]))
			
			var targ = global_line_points[i + 1] if i < get_point_count() -1 else global_position
			global_line_points[i] = lerp(global_line_points[i], targ, 0.3)
	
	global_line_points.append(global_position)
	add_point(to_local(global_position))
	
	if get_point_count() > 20:
		remove_point(0)
		global_line_points.pop_front()
