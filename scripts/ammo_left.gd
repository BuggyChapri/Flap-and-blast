extends Label

func _process(delta: float) -> void:
	self.text = str("Ammo left - ",Global.ammo)
	pass

func _ready() -> void:
	pass
