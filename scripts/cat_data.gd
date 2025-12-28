class_name CatData extends Resource

# The color pallete for the cat.
@export var pallete:Texture2D
# The value of selling the cat.
@export var value := 10

var cleanliness := 0
@export var dirty_speed := 1

var mood := 0
@export var sad_speed := 1

# Creates a cat, passes the data to it, and returns it.
func create(as_child_of:Node) -> Cat:
	var new:Cat = load("res://scenes/cat.tscn").instantiate()
	
	new.data = self
	as_child_of.add_child(new)
	
	return new
