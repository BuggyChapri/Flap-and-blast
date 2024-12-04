extends KinematicBody2D

onready var enemy_bullet = preload("res://scenes/enemy_bullet.tscn")

var velocity = Vector2()
var up = Vector2.UP

var jump_height = 300
var fall = 40
var jump_count = 0

var gravity = 10
var max_gravity = 200
var move_speed = 3

var enemy_health = 100
var player_bullet_damage = 100

var bullet
var enemy_bullet_damage = 20
var enemy_bullet_speed = 400

func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	$Sprite.flip_h = true
	velocity.y += gravity
	
	if velocity.y > max_gravity:
		velocity.y = max_gravity
	
	position.x -= move_speed
	velocity = move_and_slide(velocity,up)
	pass
	

func _on_Timer_timeout() -> void:
	if jump_count == 0:
		velocity.y = -jump_height
		jump_count = 1
	elif jump_count == 1:
		velocity.y += fall
		jump_count = 0
	velocity = move_and_slide(velocity,up)
	$Timer.start()


func _on_VisibilityNotifier2D_screen_exited() -> void:
	queue_free()

func got_hit():
	enemy_health -= player_bullet_damage
	if enemy_health <= 0:
		Global.score += 1
		Global.enemy_killed += 1
		enemy_health = 0
		$AudioStreamPlayer2D.play()
		queue_free()


func _on_Area2D_body_entered(body: Node) -> void:
	if body.has_method("collide_with_enemy"):
		body.collide_with_enemy()

func _on_Area2D2_body_entered(body: Node) -> void:
	if body.has_method("is_it_bullet"):
		body.is_it_bullet()

func enemy_gone():
	queue_free()
	pass
