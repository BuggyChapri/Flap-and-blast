extends Label


func _process(delta: float) -> void:
	self.text = str("boss health - ",Global.boss_health)
	pass

func _ready() -> void:
	pass
