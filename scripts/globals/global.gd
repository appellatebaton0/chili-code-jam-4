extends Node

## Panes

# Signals for when to move the current pane Left and Right.
signal pane_left
signal pane_right

signal pane_changed

var current_pane:Node2D # The pane the player is currently in.
var pane_moving := false # Whether the camera is currently moving from one pane to another.

@onready var panes:Array[Node2D] = get_panes()
func get_panes() -> Array[Node2D]:
	var response:Array[Node2D]
	for node in get_tree().get_nodes_in_group("Pane"):
		response.append(node)
	return response

func _leftmost(a:Node2D, b:Node2D):
	return a.global_position.x < b.global_position.x

func _ready() -> void:
	pane_left.connect(_on_pane_left)
	pane_right.connect(_on_pane_right)
	
	panes.sort_custom(_leftmost)
	
	current_pane = panes[0]

func _on_pane_left() -> void: pane_change(-1)
func _on_pane_right() -> void: pane_change(1)
func pane_change(by:int):
	var current_index = panes.find(Global.current_pane)
	current_index += by
	
	if current_index < len(panes) and current_index >= 0: 
		current_pane = panes[current_index]
		pane_changed.emit()

## Day Cycle
signal new_day

var day = 1

func next_day():
	day += 1
	new_day.emit()

## Money

signal coins_changed

var coins := 20

func pay(amount:int): 
	coins += amount
	coins_changed.emit()
