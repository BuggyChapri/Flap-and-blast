extends Control


func _ready() -> void:
	pass


func _on_start_pressed() -> void:
	get_tree().change_scene("res://scenes/main.tscn")
	

func _on_quit_pressed() -> void:
	get_tree().quit()
