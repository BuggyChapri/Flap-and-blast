extends Area2D


func _on_Area2D_body_entered(body: Node) -> void:
	if body.has_method("lol"):
		body.lol()
