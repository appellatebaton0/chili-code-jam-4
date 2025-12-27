class_name CatPot extends Area2D

enum STAGES {
	SEEDED,
	SAPLING,
	BUDDING,
	FLOWERING,
	RIPE,
}

@export var growth_stage := STAGES.SEEDED
@export var cat_seed:CatData

func _input_event(_viewport: Viewport, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton: if event.pressed:
		if growth_stage == STAGES.RIPE:
			# Make a new cat.
			
			var new = cat_seed.create(get_parent())
			new.global_position = event.global_position
			
			growth_stage = 0 as STAGES
