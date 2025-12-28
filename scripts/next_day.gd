class_name NextDay extends Button

@export var day_phaser:DayPhaser

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _pressed() -> void: day_phaser.next_day()
