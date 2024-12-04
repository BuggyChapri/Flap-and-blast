extends Label

func _process(delta: float) -> void:
	self.text = str("score - ", Global.score)
func _ready() -> void:
	pass
