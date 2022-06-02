extends StaticBody2D


signal game_finished(result)


func _ready():
	pass

func _on_Hurtbox_area_entered(hitbox):
	
	take_damage(hitbox.damage)


func take_damage(damage):
	GameData.player_data["health"] -= damage
	if GameData.player_data["health"] > 0:
		get_parent().get_parent().get_node("UI").update_health_bar(GameData.player_data["health"])
	else:
#		time_now = OS.get_unix_time()
#		playtime = time_now - time_start
#		print(playtime)
#		get_node("UI").update_health_bar(0)
#		get_node("UI/HUD/HealthAndMana/HealthManaBars/HP").value = 0
		emit_signal("game_finished", false)
