class_name KennelCell extends Area2D

@onready var anim := $AnimatedSprite2D
@onready var main := get_tree().get_first_node_in_group("Main")

@export var held:CatData

var mouse_over
func _mouse_enter() -> void: mouse_over = true
func _mouse_exit() -> void:  mouse_over = false

func _input_event(_viewport: Viewport, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton: if event.pressed and !Mouse.holding and held:
		var new = held.create(main)

		Mouse.pick_up(new)
		new.state = new.STATE.HELD
		
		anim.play("empty")
		held = null

func _pick_up(cat:Cat):
	held = cat.data
	
	material = PaletteMaterial.new()
	material.palette = held.pallete
	
	cat.queue_free()
	anim.play("full")
