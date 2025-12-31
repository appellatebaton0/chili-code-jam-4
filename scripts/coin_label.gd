class_name CoinLabel extends Label

var lerp_coins := 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.coins_changed.connect($GotCoins.play)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void: 
	@warning_ignore("narrowing_conversion")
	lerp_coins = move_toward(lerp_coins, Global.coins, 1)
	
	text = str(lerp_coins) + "K"
	tooltip_text = str(lerp_coins) + " Kitcoin"
