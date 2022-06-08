extends Control


signal StartButton_pressed()
signal StatsMenuButton_pressed()
signal ItemMenuButton_pressed()

var hero_tickets = GameData.player_data["hero_tickets"]

onready var hero_ticket_display = get_node("TopRow/HeroTicketsDisplay")


func _physics_process(delta):
	update_hero_tickets()


func update_hero_tickets():
	hero_tickets = GameData.player_data["hero_tickets"]
	hero_ticket_display.text = str(hero_tickets)


func _on_StatsMenuButton_pressed():
	emit_signal("StatsMenuButton_pressed")


func _on_ItemMenuButton_pressed():
	emit_signal("ItemMenuButton_pressed")


func _on_Start_pressed():
	emit_signal("StartButton_pressed")


func _on_DrawHeroButton_pressed():
	if hero_tickets >= 1:
		GameData.player_data["hero_tickets"] -= 1
		var draw_hero_menu = load("res://Scenes/UIScenes/DrawHeroMenu.tscn").instance()
		add_child(draw_hero_menu)
		draw_hero_menu.draw_heroes(1)
		draw_hero_menu.add_to_group("active_scenes")


func _on_DrawHeroButton10_pressed():
	if hero_tickets >= 10:
		GameData.player_data["hero_tickets"] -= 10
		var draw_hero_menu = load("res://Scenes/UIScenes/DrawHeroMenu.tscn").instance()
		add_child(draw_hero_menu)
		draw_hero_menu.draw_heroes(10)
		draw_hero_menu.add_to_group("active_scenes")
