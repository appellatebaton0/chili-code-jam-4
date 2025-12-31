class_name DayPhaser extends TextureRect

@onready var old_day := $OldDay
@onready var new_day := $NewDay

var made_switch = true

@onready var anim := find_anim()
func find_anim(with:Node = self, depth := 5) -> AnimationPlayer:
	
	if depth == 0: return null
	
	for child in with.get_children(): if child is AnimationPlayer: return child
	
	return find_anim(with.get_parent(), depth - 1)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if anim.current_animation: if anim.current_animation_position >= 3.25 and not made_switch: 
		Global.next_day()
		made_switch = true
		$DayIncrement.play()

func next_day() -> void:
	anim.play("new_day")
	
	old_day.text = str(Global.day)
	new_day.text = str(Global.day + 1)
	
	made_switch = false
