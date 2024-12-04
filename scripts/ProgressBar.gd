extends ProgressBar

onready var player: KinematicBody2D = $"../.."

func _ready() -> void:
	update_health()
	pass

func update_health():
	value = player.health * 100 / 100
