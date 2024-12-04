extends Label


func _ready() -> void:
	pass

func _process(delta: float) -> void:
	self.text = str("enemy killed -", Global.enemy_killed)
