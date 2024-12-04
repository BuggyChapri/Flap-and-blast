extends Label

func _process(delta: float) -> void:
	self.text = str("Health - ", Global.health)

func _ready() -> void:
	pass
