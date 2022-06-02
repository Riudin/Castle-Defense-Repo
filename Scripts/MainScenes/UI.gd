extends CanvasLayer

onready var hp_bar = get_node("HUD/HealthAndMana/HealthManaBars/HP")
onready var hp_bar_tween = get_node("HUD/HealthAndMana/HealthManaBars/HP/Tween")
onready var hp_label = get_node("HUD/HealthAndMana/HealthManaValues/HP")

onready var gold_display = get_node("HUD/TopRow/GoldDisplay")
onready var stage_counter = get_node("HUD/TopRow/StageCounter")
onready var wave_counter = get_node("HUD/TopRow/WaveCounter")
onready var wave_bars = get_node("HUD/TopRow/WaveBars")
onready var enemy_spawner = get_parent().get_node("EnemySpawner")

var wave_array = []

func _ready():
	initiate_wave_bars()


func _physics_process(delta):
	gold_display.text = str(GameData.player_data["gold"])
	stage_counter.text = "Stage " + str(GameData.stage_data["stage"])
	wave_counter.text = str(get_parent().get_node("EnemySpawner").current_wave) + " / " + str(get_parent().get_node("EnemySpawner").waves)


func initiate_wave_bars():
	wave_array = enemy_spawner.wave_array
	var wave_delay = 0
	for i in wave_array:
		var new_wave_bar = load("res://Scenes/SupportScenes/WaveBar.tscn").instance()
		var new_wave_bar_texture = new_wave_bar.get_node("TextureProgress")
		var new_wave_bar_tween = new_wave_bar.get_node("TextureProgress/Tween")
		wave_bars.add_child(new_wave_bar)
		new_wave_bar_tween.interpolate_property(new_wave_bar_texture, 'value', 0, 100, 5, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, wave_delay)
		new_wave_bar_tween.start()
		wave_delay += 5


func update_health_bar(wall_health):
	hp_bar.max_value = GameData.player_data["max_health"]
	hp_label.text = str(wall_health)
	hp_bar_tween.interpolate_property(hp_bar, 'value', hp_bar.value, wall_health, 0.1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	hp_bar_tween.start()


func _on_PauseButton_pressed():
	var pause_screen = load("res://Scenes/UIScenes/PauseScreen.tscn").instance()
	pause_screen.connect("quit_pressed", get_parent().get_parent(), 'show_stats_menu')
	pause_screen.connect("restart_pressed", get_parent().get_parent(), 'on_restart_pressed')
	add_child(pause_screen)	
	pause_screen.add_to_group("active_scenes")
