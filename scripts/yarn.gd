class_name Yarn extends RigidBody2D

var targeted_by:Cat

var hit_delay = 0.5
var hit_time = 0.0

@onready var area := $HitCollider

func _physics_process(delta: float) -> void:
	for body in area.get_overlapping_bodies(): if body == targeted_by:
		if hit_time == 0.0:
			var dir = body.global_position.direction_to(global_position)
			
			apply_impulse(Vector2(dir.x * 80, -80))
			targeted_by.data.mood += 10
			
			hit_time = hit_delay
	hit_time = move_toward(hit_time, 0.0, delta)
	
	if len(area.get_overlapping_bodies()): hit_time = 0
