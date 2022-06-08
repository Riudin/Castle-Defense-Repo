extends Node


func _ready():
	GameData.load_game()
#	print(get_tree().get_signal_list())
	show_stats_menu()
#	load_stats_menu()
	


#func load_stats_menu():
#	get_node("StatsMenu/TopRow/Start").connect("pressed", self, 'on_start_pressed')
#	get_node("StatsMenu/SideMenu/ItemMenuButton").connect("pressed", self, 'show_item_menu')
#	get_node("StatsMenu/SideMenu/HeroMenuButton").connect("pressed", self, 'show_hero_menu')


func delete_active_scenes():
	var active_scenes = get_tree().get_nodes_in_group("active_scenes")
	var projectiles = get_tree().get_nodes_in_group("Projectile")
	for i in active_scenes:
		i.queue_free()
	for i in projectiles:
		i.queue_free()


func start_game():
	GameData.save_game()
	delete_active_scenes()
	var game_scene = load("res://Scenes/MainScenes/GameScene.tscn").instance()
	#game_scene.connect("game_finished", self, 'game_over')
	GameData.player_data["health"] = GameData.player_data["max_health"]
	GameData.stage_data["stage"] = GameData.stage_data["max_stage"]
	add_child(game_scene)
	game_scene.add_to_group("active_scenes")


func show_stats_menu():
	GameData.save_game()
	delete_active_scenes()
	var stats_menu = load("res://Scenes/UIScenes/StatsMenu.tscn").instance()
	stats_menu.connect("StartButton_pressed", self, 'start_game')
	stats_menu.connect("ItemMenuButton_pressed", self, 'show_item_menu')
	stats_menu.connect("HeroMenuButton_pressed", self, 'show_hero_menu')
	add_child(stats_menu)
	stats_menu.add_to_group("active_scenes")


func show_item_menu():
	GameData.save_game()
	delete_active_scenes()
	var item_menu = load("res://Scenes/UIScenes/ItemMenu.tscn").instance()
	item_menu.connect("StartButton_pressed", self, 'start_game')
	item_menu.connect("StatsMenuButton_pressed", self, 'show_stats_menu')
	item_menu.connect("HeroMenuButton_pressed", self, 'show_hero_menu')
	add_child(item_menu)
	item_menu.add_to_group("active_scenes")


func show_hero_menu():
	GameData.save_game()
	delete_active_scenes()
	var hero_menu = load("res://Scenes/UIScenes/HeroMenu.tscn").instance()
	hero_menu.connect("StartButton_pressed", self, 'start_game')
	hero_menu.connect("StatsMenuButton_pressed", self, 'show_stats_menu')
	hero_menu.connect("ItemMenuButton_pressed", self, 'show_item_menu')
	add_child(hero_menu)
	hero_menu.add_to_group("active_scenes")


func game_over(result):
	if result:
		show_victory_screen()
	else:
		show_defeat_screen()


func show_defeat_screen():
	GameData.save_game()
	var defeat_screen = load("res://Scenes/UIScenes/DefeatScreen.tscn").instance()
	defeat_screen.connect("back_pressed", self, 'show_stats_menu')
	defeat_screen.connect("restart_pressed", self, 'on_restart_pressed')
	add_child(defeat_screen)	
	defeat_screen.add_to_group("active_scenes")


func on_restart_pressed():
	start_game()


func show_victory_screen():
	GameData.save_game()
	var victory_screen = load("res://Scenes/UIScenes/VictoryScreen.tscn").instance()
	victory_screen.connect("back_pressed", self, 'show_stats_menu')
	victory_screen.connect("continue_pressed", self, 'on_continue_pressed')
	add_child(victory_screen)
	victory_screen.add_to_group("active_scenes")


func on_continue_pressed():
	start_game()
	
#	delete_active_scenes()
#	var game_scene = load("res://Scenes/MainScenes/GameScene.tscn").instance()
#	game_scene.connect("game_finished", self, 'game_over')
#	GameData.player_data["health"] = GameData.player_data["max_health"]
#	GameData.stage_data["stage"] = GameData.stage_data["max_stage"]
#	add_child(game_scene)
#	game_scene.add_to_group("active_scenes")


#func unload_game():
#	GameData.save_game()
#	delete_active_scenes()
#	var stats_menu_scene = load("res://Scenes/UIScenes/StatsMenu.tscn").instance()
#	add_child(stats_menu_scene)
#	stats_menu_scene.add_to_group("active_scenes")
#	load_stats_menu()


func _notification(what):
	if what == MainLoop.NOTIFICATION_WM_QUIT_REQUEST:
		GameData.save_game()
		get_tree().quit() 
	if what == MainLoop.NOTIFICATION_WM_GO_BACK_REQUEST:
		GameData.save_game()
		get_tree().quit()
	if what == MainLoop.NOTIFICATION_WM_FOCUS_OUT:
		GameData.save_game()
