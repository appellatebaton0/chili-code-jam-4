class_name CoinLabel extends Label

var lerp_coins := 0.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.coins_changed.connect($GotCoins.play)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void: 
	lerp_coins = lerp(lerp_coins, float(Global.coins), 0.3)
	text = str(int(lerp_coins)) + "K"
	tooltip_text = str(int(lerp_coins)) + " Kitcoin"
