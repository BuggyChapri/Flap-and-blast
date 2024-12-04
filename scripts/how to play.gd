extends Control


func _ready() -> void:
	pass

func _process(delta: float) -> void:
	if $AudioStreamPlayer.playing == false:
		$AudioStreamPlayer.play()

func _on_Button_pressed() -> void:
	get_tree().change_scene("res://scenes/main_menu.tscn")
