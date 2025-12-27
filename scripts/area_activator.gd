class_name AreaActivator extends Area2D

signal activated

@export var signal_name:String

func _input_event(_viewport: Viewport, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouse and not Global.pane_moving:
		Global.emit_signal(signal_name)
		activated.emit()
