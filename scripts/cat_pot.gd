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
			new.data.name = get_new_name()
			print("named new ", new.data.name)
			
			growth_stage = 0 as STAGES
			
			particles.emitting = true

func get_new_name() -> String:
	return [
		"Alex",
		"Bailey",
		"Charlie",
		"Chris",
		"Dakota",
		"Tabby",
		"Milo",
		"Jamie",
		"Jordan",
		"Morgan",
		"Riley",
		"Sam",
		"Taylor",
		"Casey",
		"Robin",
		"Avery",
		"Otto",
		"Tucker",
		"Sidney",
		"Kim",
		"Lucky",
		"Pat",
		"Tatum",
		"Max",
		"Biscuit",
		"Brownie",
		"Butterscotch",
		"Caramel",
		"Coffee",
		"Oreo",
		"Chili",
		"Cupcake",
		"Cookie",
		"Muffin",
		"Cosmo",
		"Fanta",
		"Tini",
		"Peanut",
		"Pudding",
		"Quinoa",
		"Chicken",
		"Porkchop",
		"Potato",
		"Bean",
		"Ramen",
		"Latte",
		"Snickers",
		"Tofu",
		"Waffles",
		"S'mores",
		"Marg",
		"Olive",
		"Noodle",
		"Mochi",
		"Pumpkin",
		"Honey",
		"Blossom",
		"Breeze",
		"Clover",
		"Coral",
		"Fern",
		"Grove",
		"Lark",
		"Maple",
		"Leave",
		"Ocean",
		"Winter",
		"Petal",
		"Rain",
		"Rocky",
		"Sierra",
		"Sky",
		"Stone",
		"Thorn",
		"Spring",
		"Tulip",
		"Wren",
		"Zephyr",
		"Birch",
		"Cypress",
		"Juniper",
		"Meadow",
		"Pine",
		"Windy",
		"Aster",
		"Dew",
		"Harvest",
		"Lotus",
		"Nettle",
		"Poppy",
		"Sage",
		"Willow",
		"Sunset",
		].pick_random()
