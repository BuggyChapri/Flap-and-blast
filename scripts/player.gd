extends KinematicBody2D

onready var bullet_file = preload("res://scenes/bullet.tscn")


var velocity = Vector2()
var up = Vector2.UP
var jump_height = 200
var gravity = 10
var max_gravity = 200
var move_speed = 4
var bullet
var bullet_velocity = Vector2()
var bullet_speed = 1600
var pipe_damage = 100
var die = false
var enemy_damage = 25
var enemy_bullet_damage = 20
var lower_pipe_damage = 100

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("shoot") and Global.ammo > 0:
		bullet = bullet_file.instance()
		get_parent().add_child(bullet)
		bullet.global_position = $Position2D.global_position
		bullet.apply_impulse(Vector2(),Vector2(bullet_speed,0).rotated(rotation))
		Global.ammo -= 1
		$shoot.play()
	elif Input.is_action_just_pressed("reload") and Global.ammo == 0:
		Global.ammo += 5
	

func _physics_process(delta: float) -> void:
	
	if Input.is_action_just_pressed("shoot"):
		$AnimatedSprite.play("shoot")
	elif Input.is_action_just_pressed("reload"):
		$AnimatedSprite.play("idle")
	

	velocity.y += gravity
	if velocity.y > max_gravity:
		velocity.y = max_gravity
	
	if Input.is_action_just_pressed("jump"):
		velocity.y = -jump_height
		$jump.play()
	
	position.x += move_speed
	
	
	velocity = move_and_slide(velocity,up)

func got_hit_by_pipe():
	Global.health -= pipe_damage
	$hit.play()
	if Global.health <= 0 :
		Global.score = 0
		Global.health = 100
		Global.ammo = 5 + 1
		Global.enemy_killed = 0
		set_physics_process(die)
		get_tree().change_scene("res://scenes/dead.tscn")

func collide_with_enemy():
	Global.health -= enemy_damage
	$hit.play()
	if Global.health <= 0:
		Global.score = 0
		Global.ammo = 5 + 1
		Global.health = 100
		Global.enemy_killed = 0
		set_physics_process(die)
		get_tree().change_scene("res://scenes/dead.tscn")
		

func lol():
	Global.health -= lower_pipe_damage
	$hit.play()
	if Global.health <= 0:
		Global.score = 0
		Global.ammo = 5 + 1
		Global.health = 100
		Global.enemy_killed = 0
		set_physics_process(die)
		get_tree().change_scene("res://scenes/dead.tscn")

func player_pass():
	Global.score += 1
	$points.play()

func player_got_hit():
	Global.health -= enemy_damage
	$hit.play()
	$hit.play()
	if Global.health <= 0:
		Global.health = 100
		Global.ammo = 5 + 1
		Global.score = 0
		Global.enemy_killed = 0
		set_physics_process(die)
		get_tree().change_scene("res://scenes/dead.tscn")
		

func got_hit_by_enemy_bullet():
	Global.health -= enemy_bullet_damage
	if Global.health <= 0:
		Global.health = 100
		set_physics_process(die)
		$hit.play()

func _on_hitbox_body_entered(body: Node) -> void:
	if body.has_method("enemy_gone"):
		body.enemy_gone()

func boss_arrived():
	move_speed = 2
	if Global.boss_health <= 40:
		move_speed = 4
		Global.health = 100
