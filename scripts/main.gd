extends Node2D

onready var enemy_file = preload("res://scenes/enemy.tscn")
onready var player_file = preload("res://scenes/player.tscn")
onready var boss_file = preload("res://scenes/boss_fight.tscn")

onready var upper_pipe_file = preload("res://scenes/upper.tscn")
onready var lower_pipe_file = preload("res://scenes/lower_pipe.tscn")
onready var lower_positions_file = preload("res://scenes/lower_position.tscn")
onready var upper_positions_file = preload("res://scenes/up_position.tscn")

var upper_pipe
var lower_pipe
var last_pipe_position = Vector2.ZERO
var ran = RandomNumberGenerator.new()
var enemy
var player
var boss

func _ready() -> void:
	ran.randomize()

func _process(delta: float) -> void:
	if $AudioStreamPlayer.playing == false:
		$AudioStreamPlayer.play()

func _on_Timer_timeout() -> void:
	upper_pipe = upper_pipe_file.instance()
	lower_pipe = lower_pipe_file.instance()
	
	var upper_position = upper_positions_file.instance()
	var lower_position = lower_positions_file.instance()

	var lower_pipe_y = ran.randi_range(100, get_viewport_rect().size.y - 300)
	var pipe_horizontal_spacing = 300 

	last_pipe_position.x += pipe_horizontal_spacing

	var screen_size = get_viewport_rect().size
	var normalized_last_pipe_position = last_pipe_position / screen_size
	upper_pipe.position = upper_position.position + normalized_last_pipe_position * screen_size
	lower_pipe.position = lower_position.position + normalized_last_pipe_position * screen_size + Vector2(0, lower_pipe_y)

	add_child(upper_pipe)
	add_child(lower_pipe)

	$Timer.start()


func _on_spawner_timeout() -> void:
	enemy = enemy_file.instance()
	player = player_file.instance()
	add_child(enemy)
	enemy.global_position = $player/spawn_position.global_position
	$spawner.start()
	pass



func _on_boss_spawner_timeout() -> void:
	if Global.enemy_killed == 30:
		boss = boss_file.instance()
		add_child(boss)
		boss.global_position = $player/spawn_position.global_position
		$boss_spawner.stop()
		$spawner.stop()
	pass


func _on_spawner_start_timeout() -> void:
	$spawner.start()

