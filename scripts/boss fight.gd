extends KinematicBody2D

onready var enemy_bullet_file = preload("res://scenes/enemy_bullet.tscn")

var velocity = Vector2()
var up = Vector2.UP
var jump_count = 0
var gravity = 10
var max_gravity = 250
var move_speed = 2
var jump_height = 300
var fall = 40
var enemy_bullet 
var enemy_bullet_speed = 1600
var player_bullet_damage = 20
var killed

func _ready() -> void:
	pass
	
func _physics_process(delta: float) -> void:
	velocity.y += gravity
	if velocity.y > max_gravity:
		velocity.y = max_gravity
	
	position.x += move_speed 
	velocity = move_and_slide(velocity,up)


func _on_Timer_timeout() -> void:
	if jump_count == 0:
		velocity.y = -jump_height
		jump_count = 1
	elif jump_count == 1:
		velocity.y += fall
		jump_count = 0
		
	enemy_bullet = enemy_bullet_file.instance()
	add_child(enemy_bullet)
	enemy_bullet.global_position = $shoot.global_position
	enemy_bullet.apply_impulse(Vector2(),Vector2(-enemy_bullet_speed,0).rotated(rotation))
	$AnimatedSprite.play("shoot")
	$AnimatedSprite.play("idle")
	velocity = move_and_slide(velocity)
	$Timer.start()

func got_hit():
	Global.boss_health -= player_bullet_damage
	if Global.boss_health <= 0:
		Global.score += 50
		queue_free()
		
	

func _on_Area2D_body_entered(body: Node) -> void:
	if body.has_method("boss_arrived"):
		body.boss_arrived()


