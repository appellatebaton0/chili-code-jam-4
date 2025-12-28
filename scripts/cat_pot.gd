class_name CatPot extends Area2D

enum STAGES {
	SEEDED,
	SAPLING,
	BUDDING,
	FLOWERING,
	RIPE,
}

@export var growth_per_day := 1.0
var growth_progress := 0.0

@export var growth_stage := STAGES.SEEDED
@export var cat_seed:CatData

@onready var particles := $HarvestParticles

func _ready() -> void: Global.new_day.connect(_on_new_day)

func _on_new_day() -> void:
	growth_progress += growth_per_day
	
	while growth_progress >= 1.0:
		growth_stage = min((growth_stage + 1) as STAGES, STAGES.RIPE)
		growth_progress -= 1.0

func _input_event(_viewport: Viewport, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton: if event.pressed:
		if growth_stage == STAGES.RIPE:
			# Make a new cat.
			
			var new = cat_seed.duplicate().create(get_parent())
			new.global_position = event.global_position
			
			growth_stage = 0 as STAGES
			
			particles.emitting = true
