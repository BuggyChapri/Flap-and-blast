extends RigidBody2D

func _ready() -> void:
	pass

func _on_Area2D_body_entered(body: Node) -> void:
	if body.has_method("got_hit_by_enemy_bullet"):
		body.got_hit_by_enemy_bullet()

func Is_it_enemy_bullet():
	queue_free()



func _on_bullet_gone_body_entered(body: Node) -> void:
	if body.has_method("enemy_bullet_touch"):
		body.enemy_bullet_touch()

func boss_touch_the_bullet():
	queue_free()
