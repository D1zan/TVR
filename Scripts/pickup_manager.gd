extends Node




@onready var coin_label = $"../Player/CanvasLayer/Control/CoinLabel"


func _ready():
	update_score_label()
	
func add_point():
	Global.add_point()
	update_score_label()
	
func update_score_label():
	coin_label.text = "Score: " + str(Global.score)
	
		 
	
