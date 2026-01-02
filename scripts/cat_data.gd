class_name CatData extends Resource

@export var name:String = "-1-"

# The color pallete for the cat.
@export var pallete:Texture2D
# The value of selling the cat.
@export var value := 10

var cleanliness := 70
@export var dirty_speed := 1

var mood := 50
@export var sad_speed := 1

func _init() -> void:
	pallete = get_palletes().pick_random()
	name = "Dave"

# Creates a cat, passes the data to it, and returns it.
func create(as_child_of:Node) -> Cat:
	var new:Cat = load("res://scenes/cat.tscn").instantiate()
	
	new.data = self
	as_child_of.add_child(new)
	
	return new

func change_mood(by:int):
	mood = max(0, min(100, mood + by))
func change_cleanliness(by:int):
	cleanliness = max(0, min(100, cleanliness + by))

func get_palletes() -> Array[Texture2D]:
	var dir = DirAccess.open("res://assets/textures/palletes")
	var response:Array[Texture2D]
	
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			
			if file_name.contains(".import"): 
				file_name = dir.get_next()
				continue
			file_name.replace(".remap", "")
			
			if !dir.current_is_dir():
				var file = load("res://assets/textures/palletes/" + file_name)
				if file is Texture2D: response.append(file)
			file_name = dir.get_next()
	else:
		print("An error occurred when trying to access the path.")
	
	return response
