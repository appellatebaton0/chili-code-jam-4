class_name Computer extends Area2D

signal sold

@onready var cat_name := $Control/Name
@onready var mood := $Control/Mood
@onready var clean := $Control/Clean
@onready var sell := $Control/Sell

@onready var anim := $AnimatedSprite2D

@export var held:CatData

var can_sell := false
func _process(_delta: float) -> void:
	
	if held == null: can_sell = false
	else: can_sell = held.mood >= 90 and held.cleanliness >= 90
	
	sell.disabled = not can_sell
	
	if held:
		var value_multiplier := (held.mood + held.cleanliness) / 200.0
		
		mood.value = lerp(mood.value, float(held.mood), 0.3)
		clean.value = lerp(clean.value, float(held.cleanliness), 0.3)
		
		cat_name.text = held.name
		sell.text = "Sell " + str(int(held.value * value_multiplier)) + "k"
	else:
		mood.value = lerp(mood.value, 0.0, 0.3)
		clean.value = lerp(clean.value, 0.0, 0.3)
		
		cat_name.text = "None"
		sell.text = "Sell"
	

var mouse_over
func _mouse_enter() -> void: mouse_over = true
func _mouse_exit() -> void:  mouse_over = false

func _input_event(_viewport: Viewport, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton: if event.pressed and !Mouse.holding and held:
		var new = held.create(get_parent().get_parent())

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


func _on_sell_pressed() -> void: if can_sell:
	
	var value_multiplier := (held.mood + held.cleanliness) / 200.0
	
	Global.pay(int(held.value * value_multiplier))
	
	anim.play("empty")
	held = null

	sold.emit()
