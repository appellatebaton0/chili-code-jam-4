class_name Cat extends CharacterBody2D

var data:CatData

@onready var anim := $AnimatedSprite2D
@onready var cleaning := $Cleaning

enum STATE {HELD, MIDAIR, IDLE, WALKING, YARN}
var state := STATE.IDLE

var state_time := 0.0
var facing_left := false

var walk_speed := 10.0

var mouse_over := false
@onready var tooltip := $Info
@onready var mood := $Info/Panel/Mood
@onready var clean := $Info/Panel/Cleanliness

var current_yarn:Yarn
@export var can_play := true

func _ready() -> void:
	if data == null: data = CatData.new()
	
	material = PaletteMaterial.new()
	material.set_palette(data.pallete)

func _input_event(_viewport: Viewport, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton: if event.pressed:
		if !Mouse.holding:
			Mouse.pick_up(self)
			

func _physics_process(delta: float) -> void:
	
	if not is_on_floor() and Mouse.holding != self: 
		velocity += get_gravity() * delta * 0.9
		state = STATE.MIDAIR if Mouse.holding != self else STATE.HELD
	
	if state_time <= 0 and data.mood < 90 and can_play: change_state(STATE.YARN)
	
	if randf() >= 0.98: data.mood -= 1
	
	match state:
		STATE.IDLE:
			anim.play("idle", randf_range(0.0, 1.0))
			
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
		STATE.YARN:
			anim.play("walking", walk_speed / 15)
			
			facing_left = current_yarn.global_position.x < global_position.x
			
			velocity.x = (-1 if facing_left else 1) * walk_speed
			
			if data.mood >= 95 and state_time <= 0: change_state(STATE.IDLE)
			
	state_time = move_toward(state_time, 0, delta)
	
	if velocity.x: anim.flip_h = velocity.x > 0
	
	velocity.x /= 1.2
	
	move_and_slide()
	
	var show_tooltip = mouse_over or Mouse.holding == self
	
	tooltip.modulate.a = move_toward(tooltip.modulate.a, 1.0 if show_tooltip else 0.0, 5 *delta)
	if show_tooltip: 
		tooltip.global_position = get_global_mouse_position()
		
		mood.value = data.mood
		clean.value = data.cleanliness
		
		$Info/Panel/Name.text = data.name
	
func change_state(to:STATE):
	if current_yarn: current_yarn.targeted_by = null
	
	state = to
	
	facing_left = randf() > 0.5
	walk_speed = randf_range(6.0, 24.0)
	
	match to:
		STATE.IDLE: state_time = randf_range(1.0, 10.0)
		STATE.WALKING: state_time = randf_range(1.0, 9.0)
		STATE.YARN:
			walk_speed = randf_range(16.0, 32.0)
			state_time = randf_range(7.0, 15.0)
			
			current_yarn = find_yarn()
			
			if not current_yarn: change_state(STATE.WALKING)
			else: current_yarn.targeted_by = self


func _on_mouse_entered() -> void: mouse_over = true
func _on_mouse_exited() -> void:  mouse_over = false

func find_yarn() -> Yarn:
	
	var response:Yarn = null
	var min_distance := 1000000.0
	
	for yarn in get_tree().get_nodes_in_group("Yarn"): if yarn is Yarn:
		if abs(global_position.y - yarn.global_position.y) > 20: continue
		
		if not yarn.targeted_by and abs(yarn.global_position.x - global_position.x) < min_distance:
			response = yarn
			min_distance = abs(yarn.global_position.x - global_position.x)
	
	return response
