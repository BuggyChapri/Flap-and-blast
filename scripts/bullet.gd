extends RigidBody2D

func _ready() -> void:
	pass

func _on_Area2D_body_entered(body: Node) -> void:
	if body.has_method("got_hit"):
		body.got_hit()

func is_it_bullet():
	queue_free()



func _on_bullet_gone_body_entered(body: Node) -> void:
	if body.has_method("boss_touch_the_bullet"):
		body.boss_touch_the_bullet() 

func enemy_bullet_touch():
	queue_free()
