extends Node2D


#signal game_finished(result)
signal weapon_ticket_looted()

onready var enemy_spawner = get_node("EnemySpawner")
onready var player = get_node("Player")

var time_start = 0
var time_now = 0
var playtime = 0 setget set_playtime, get_playtime


func _ready():
	get_node("UI").update_health_bar(GameData.player_data["health"])
	#player.connect("game_finished", self, 'game_over')
	player.connect("game_finished", get_parent(), 'game_over')
#	enemy_spawner.connect("wall_damage", self, 'on_wall_damage')
	enemy_spawner.connect("loot_time", self, 'generate_loot')
	enemy_spawner.connect("game_finished", get_parent(), 'game_over')
	time_start = OS.get_unix_time()


func game_over(result):
	if result:
		return
	else:
		time_now = OS.get_unix_time()
		playtime = time_now - time_start


#func on_wall_damage(damage): 
#	GameData.player_data["health"] -= damage
#	if GameData.player_data["health"] > 0:
#		get_node("UI").update_health_bar(GameData.player_data["health"])
#	else:
#		time_now = OS.get_unix_time()
#		playtime = time_now - time_start
#		print(playtime)
#		get_node("UI").update_health_bar(0)
#		get_node("UI/HUD/HealthAndMana/HealthManaBars/HP").value = 0
#		emit_signal("game_finished", false)


func generate_loot():
	# loot has a chance to spawn after every level
	# loot array = loot name in GameData, drop chance in %
	var loot = [["weapon_tickets", 50], ["hero_tickets", 50]]
	var victory_screen = get_node("../VictoryScreen")
	
	for item in loot:
		randomize()
		var dice_roll = round(rand_range(1, 100))
		print(dice_roll)
		if dice_roll <= item[1]:
			GameData.player_data[item[0]] += 1
			var loot_display = victory_screen.get_node("VictoryScreenContainer/PanelContainer/MarginContainer/Rows/Loot")
			var loot_icons = victory_screen.get_node("VictoryScreenContainer/PanelContainer/MarginContainer/Rows/Loot/LootIcons")
			
			if item[0] == "weapon_tickets":
				var new_weapon_ticket = load("res://Scenes/Loot/WeaponTicket.tscn").instance()
				emit_signal("weapon_ticket_looted")
				loot_display.visible = true
				loot_icons.add_child(new_weapon_ticket)
				
			elif item[0] == "hero_tickets":
				var new_hero_ticket = load("res://Scenes/Loot/HeroTicket.tscn").instance()
				emit_signal("hero_ticket_looted")
				loot_display.visible = true
				loot_icons.add_child(new_hero_ticket)


func set_playtime(time):
	playtime = time


func get_playtime():
	return playtime


func time_convert(time_in_sec):
	var seconds = time_in_sec%60
	var minutes = (time_in_sec/60)%60

	#returns a string with the format "MM:SS"
	return "%02d:%02d" % [minutes, seconds]
