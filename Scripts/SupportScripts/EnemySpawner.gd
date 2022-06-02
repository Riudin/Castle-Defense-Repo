extends Node2D


signal game_finished(result)
signal wall_damage(damage)
signal loot_time()

var current_stage = GameData.stage_data["stage"]
var max_stage = GameData.stage_data["max_stage"]
var waves = 3
var current_wave = 0
var enemies_in_wave = 0
var max_enemies = 15

var time_start = 0
var time_now = 0

var enemies_killed = 0 setget , get_enemies_killed

var wave_rows = 5
var wave_columns = 3

var taken_spaces = []
var wave_array = []

onready var spawn_area = get_node("EnemySpawn")


func _ready():
	time_start = OS.get_unix_time()
	enemies_killed = 0
	wave_columns += round(current_stage / 10)
	waves += round(current_stage / 10)
	max_enemies += 5 * round(current_stage / 10)
	while wave_array.count(["Wave"]) < waves:
		wave_array.append(["Wave"])
	current_stage = GameData.stage_data["stage"]
	_on_WaveSpawnTimer_timeout()


func start_waves():
	pass


func _on_WaveSpawnTimer_timeout():
	if current_wave + 1 <= waves:
		start_next_wave()
	#check_enemy_count()


func on_enemy_killed():
	enemies_killed += 1
	check_enemy_count()


func check_enemy_count():
	if current_wave == waves and get_node("EnemySpawn").get_child_count() <= 1:
		yield(get_tree().create_timer(0.5), "timeout")
		GameData.stage_data["max_stage"] += 1
		time_now = OS.get_unix_time()
		get_parent().set_playtime(time_now - time_start)
#		emit_signal("loot_time")
		emit_signal("game_finished", true)
		emit_signal("loot_time")
		print("loot_signal")


func start_next_wave():
	taken_spaces = []
	var wave_data = retrieve_wave_data()
	spawn_enemies(wave_data)
	current_wave += 1


func retrieve_wave_data():
	var wave_data = [] 
	var bat_count = current_stage + round(current_stage * 0.2)
	if bat_count > max_enemies:
		bat_count = max_enemies
	while wave_data.count(["Bat"]) < bat_count:
		wave_data.append(["Bat"])
	#enemies_in_wave = wave_data.size()
	return wave_data


func spawn_enemies(wave_data):
	for i in wave_data:
		var x_pos = round(rand_range(1, wave_columns)) * 10
		var y_pos = round(rand_range(1, wave_rows)) * 20
		
		var new_enemy = load("res://Scenes/Enemies/" + i[0] + ".tscn").instance()
		
		var enemy_spawn_location = Vector2(x_pos, y_pos)
		while enemy_spawn_location in taken_spaces:
			x_pos = round(rand_range(1, wave_columns)) * 10
			y_pos = round(rand_range(1, wave_rows)) * 20
			enemy_spawn_location = Vector2(x_pos, y_pos)
			new_enemy.position = enemy_spawn_location
		taken_spaces.append(enemy_spawn_location)
		
		new_enemy.connect("wall_damage", get_parent(), 'on_wall_damage')
		new_enemy.connect("enemy_killed", self, 'on_enemy_killed')
		new_enemy.position = enemy_spawn_location
		spawn_area.add_child(new_enemy, true)


func get_enemies_killed():
	return enemies_killed
