extends Control


signal StatsMenuButton_pressed()
signal HeroMenuButton_pressed()

var weapon_tickets = GameData.player_data["weapon_tickets"]

onready var weapon_ticket_display = get_node("TopRow/WeaponTicketsDisplay")


func _physics_process(delta):
	update_weapon_tickets()


func update_weapon_tickets():
	weapon_tickets = GameData.player_data["weapon_tickets"]
	weapon_ticket_display.text = str(weapon_tickets)





func _on_StatsMenuButton_pressed():
	emit_signal("StatsMenuButton_pressed")


func _on_HeroMenuButton_pressed():
	emit_signal("HeroMenuButton_pressed")
