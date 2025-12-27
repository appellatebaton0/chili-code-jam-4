class_name AnimateButton extends Button

@export var anim_name := ""

@onready var anim := find_anim()
func find_anim(with:Node = self, depth := 5) -> AnimationPlayer:
	
	if depth == 0: return null
	
	for child in with.get_children(): if child is AnimationPlayer: return child
	
	return find_anim(with.get_parent(), depth - 1)

func _pressed() -> void:
	anim.play(anim_name)
