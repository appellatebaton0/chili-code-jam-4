class_name Cat extends CharacterBody2D

var data:CatData

func _ready() -> void:
	if data == null: queue_free()
	
	material = PaletteMaterial.new()
	material.palette = data.pallete

func _input_event(_viewport: Viewport, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton: if event.pressed:
		if !Mouse.holding:
			Mouse.pick_up(self)
