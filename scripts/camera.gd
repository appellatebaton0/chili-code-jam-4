class_name Camera extends Camera2D
# The camera.

@export var speed := 0.3
var progress := 0.0

func _ready() -> void:
	Global.pane_changed.connect(_on_pane_changed)
	_on_pane_changed()

func _on_pane_changed() -> void:
	Global.pane_moving = true

func _process(delta: float) -> void: if Global.pane_moving:
	
	var curr = global_position.x
	var goal = Global.current_pane.global_position.x
	
	# Lerp to the goal based on a curved rep of the progress.
	global_position.x = lerp(curr, goal, ease(progress, -2.5))
	global_position.y = 81
	
	progress = move_toward(progress, 1.0, delta * speed)
	
	if progress >= 1.0:
		Global.pane_moving = false
		progress = 0.0
