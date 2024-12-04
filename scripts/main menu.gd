extends Control

func _process(delta: float) -> void:
	if $AudioStreamPlayer.playing == false:
		$AudioStreamPlayer.play()
	pass

func _on_start_pressed() -> void:
	get_tree().change_scene("res://scenes/main.tscn")


func _on_quit_toggled(button_pressed: bool) -> void:
	get_tree().quit()
	


func _on_how_to_play_toggled(button_pressed: bool) -> void:
	get_tree().change_scene("res://scenes/how to play.tscn")
