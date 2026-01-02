class_name Yarn extends RigidBody2D

var targeted_by:Cat

var hit_delay = 0.5
var hit_time = 0.0

@onready var area := $HitCollider

var mouse_over := false
var mult := 50.0

func _ready() -> void: $Sprite2D.frame = randi_range(0, 4)

func _physics_process(delta: float) -> void:
	for body in area.get_overlapping_bodies(): if body == targeted_by:
		if hit_time == 0.0:
			var dir = body.global_position.direction_to(global_position)
			
			apply_impulse(Vector2(dir.x * mult, -mult))
			targeted_by.data.mood += 10 if Mouse.holding != self else randi_range(0, 1)
			
			hit_time = hit_delay
	hit_time = move_toward(hit_time, 0.0, delta)
	
	if len(area.get_overlapping_bodies()) <= 0: hit_time = 0

func _on_mouse_entered() -> void: mouse_over = true
func _on_mouse_exited() -> void:  mouse_over = false

func _input_event(_viewport: Viewport, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton: if event.pressed:
		if !Mouse.holding:
			Mouse.pick_up(self)
