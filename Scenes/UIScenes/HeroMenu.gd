extends Control


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
