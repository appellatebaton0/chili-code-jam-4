class_name AreaActivator extends Area2D

signal activated

@export var signal_name:String
var mouse_over := false
@export var input_name:String

func _mouse_enter() -> void: mouse_over = true
func _mouse_exit() -> void:  mouse_over = false

func _process(_delta: float) -> void: if (mouse_over or Input.is_action_just_pressed(input_name)) and not Global.pane_moving:
	Global.emit_signal(signal_name)
	activated.emit()
