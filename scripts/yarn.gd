class_name Yarn extends RigidBody2D

var targeted_by:Cat

var hit_delay = 0.5
var hit_time = 0.0

@onready var area := $HitCollider

var mouse_over := false
var mult := 20.0

func _ready() -> void: 
	$Sprite2D.frame = randi_range(0, 4)
	
	for line in get_children(): if line is YarnLine:
		line.default_color = $Sprite2D.texture.get_image().get_pixel(3 + ($Sprite2D.frame * 8),0)

func _physics_process(delta: float) -> void:
	for body in area.get_overlapping_bodies(): if body == targeted_by:
		if hit_time == 0.0:
			var dir = 1 if body.global_position.direction_to(global_position).x < 0 else 1
			
			if Mouse.holding != self:
				apply_impulse(Vector2(dir * mult, -mult * 1.1))
			targeted_by.data.mood += 10 if Mouse.holding != self else 7
			
			hit_time = hit_delay
	hit_time = move_toward(hit_time, 0.0, delta)
	


func _on_mouse_entered() -> void: mouse_over = true
func _on_mouse_exited() -> void:  mouse_over = false

func _input_event(_viewport: Viewport, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton: if event.pressed:
		if !Mouse.holding:
			Mouse.pick_up(self)
