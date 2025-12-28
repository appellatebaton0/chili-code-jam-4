extends Node2D
# Handles mouse stuff and things

var holding:Cat
var hold_offset:Vector2

var last_relative:Vector2
var relative_hold_time := 0.0

func _process(delta: float) -> void:
	if holding:
		holding.global_position = get_global_mouse_position() # + hold_offset
		
		relative_hold_time = move_toward(relative_hold_time, 0, delta)
		
		if relative_hold_time <= 0: last_relative = Vector2.ZERO

func pick_up(cat:Cat) -> bool:
	
	if holding: return false
	
	holding = cat
	hold_offset = cat.global_position - get_global_mouse_position()
	holding.z_index += 1
	
	cat.change_state(cat.STATE.HELD)
	
	return true
func put_down() -> bool:
	if !holding: return false
	
	var in_kennel:KennelCell = null
	
	for kennel in get_tree().get_nodes_in_group("Kennel"): if kennel is KennelCell:
		if kennel.mouse_over: 
			in_kennel = kennel
			break
	
	if in_kennel: in_kennel._pick_up(holding)
	else:
		holding.velocity = last_relative * 2.5
		holding.change_state(holding.STATE.MIDAIR)
		
		holding.z_index -= 1
		holding = null
	
	return true

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		last_relative = event.relative * Vector2(17, 9)
		relative_hold_time = 0.3
	elif event is InputEventMouseButton: if !event.pressed and holding:
		put_down()
