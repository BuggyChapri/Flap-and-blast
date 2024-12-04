extends KinematicBody2D

func _on_Area2D_body_entered(body: Node) -> void:
	if body.has_method("got_hit_by_pipe"):
		body.got_hit_by_pipe()

func _on_points_body_entered(body: Node) -> void:
	if body.has_method("player_pass"):
		body.player_pass()


