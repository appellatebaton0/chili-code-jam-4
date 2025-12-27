class_name CatData extends Resource

# The color pallete for the cat.
@export var pallete:Texture2D
# The value of selling the cat.
@export var value := 10

# Creates a cat, passes the data to it, and returns it.
func create(as_child_of:Node) -> Cat:
	var new:Cat = load("res://scenes/cat.tscn").instantiate()
	
	new.data = self
	as_child_of.add_child(new)
	
	return new
