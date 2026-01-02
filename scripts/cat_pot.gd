class_name CatPot extends Area2D

@export var bought := false
@export var cost := 20

@onready var anim := $AnimatedSprite2D
@export var colliders:Array[CollisionShape2D]

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

func _ready() -> void:
	Global.new_day.connect(_on_new_day)
	for collider in colliders:
		collider.disabled = not bought
	anim.play("unbought")
	
	material = PaletteMaterial.new()
	material.palette = cat_seed.pallete

func _on_new_day() -> void:
	if not bought: return
	
	if growth_stage == STAGES.RIPE:
		# Make a new cat.
			
		var new = cat_seed.duplicate().create(get_parent())
		new.global_position = global_position
		new.data.name = get_new_name()
		
		growth_stage = 0 as STAGES
		
		particles.emitting = true
		
		anim.play(str(growth_stage))
	
	growth_progress += growth_per_day
	
	while growth_progress >= 1.0:
		growth_stage = min((growth_stage + 1) as STAGES, STAGES.RIPE)
		growth_progress -= 1.0
	
	anim.play(str(growth_stage))

func _input_event(_viewport: Viewport, event: InputEvent, _shape_idx: int) -> void:
	if not bought: return
	
	if event is InputEventMouseButton: if event.pressed:
		if growth_stage == STAGES.RIPE:
			# Make a new cat.
			
			var new = cat_seed.duplicate().create(get_parent())
			new.global_position = event.global_position
			new.data.name = get_new_name()
			
			growth_stage = 0 as STAGES
			
			particles.emitting = true
			
			anim.play(str(growth_stage))

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


func _on_button_pressed() -> void: if Global.coins >= cost:
	Global.pay(-cost)
	
	$Buy.hide()
	bought = true
	
	for collider in colliders:
		collider.disabled = not bought
	
	anim.play(str(growth_stage))
	
	for pot in get_tree().get_nodes_in_group("Pot"): if pot is CatPot:
		pot._update_cost_to(int(cost * 1.1))

func _update_cost_to(amount:int):
	
	cost = amount
	$Buy/Label2.text = str(amount) + "k"
