class_name Cat extends CharacterBody2D

var data:CatData

@onready var anim := $AnimatedSprite2D

enum STATE {HELD, MIDAIR, IDLE, WALKING}
var state := STATE.IDLE

var state_time := 0.0
var facing_left := false

var walk_speed := 10.0

func _ready() -> void:
	if data == null: queue_free()
	
	material = PaletteMaterial.new()
	material.palette = data.pallete
	
	

func _input_event(_viewport: Viewport, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton: if event.pressed:
		if !Mouse.holding:
			Mouse.pick_up(self)
			

func _physics_process(delta: float) -> void:
	
	if not is_on_floor(): 
		velocity += get_gravity() * delta * 0.9
		state = STATE.MIDAIR if Mouse.holding != self else STATE.HELD
		
	
	match state:
		STATE.IDLE:
			anim.play("idle")
			
			if state_time <= 0: change_state(STATE.WALKING)
		STATE.WALKING:
			anim.play("walking", walk_speed / 15)
			
			if is_on_wall(): facing_left = get_wall_normal().x < 0
			
			velocity.x = (-1 if facing_left else 1) * walk_speed
		
			if state_time <= 0: change_state(STATE.IDLE)
		STATE.MIDAIR:
			if is_on_floor(): change_state(STATE.IDLE)
		STATE.HELD:
			anim.play("held")
	state_time = move_toward(state_time, 0, delta)
	
	
	
	if velocity.x: anim.flip_h = velocity.x > 0
	
	velocity.x /= 1.2
	
	move_and_slide()

func change_state(to:STATE):
	state = to
	
	facing_left = randf() > 0.5
	walk_speed = randf_range(6.0, 24.0)
	
	match to:
		STATE.IDLE: state_time = randf_range(1.0, 10.0)
		STATE.WALKING: state_time = randf_range(1.0, 9.0)
