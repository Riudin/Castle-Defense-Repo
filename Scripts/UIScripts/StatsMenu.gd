extends Control


signal StartButton_pressed()
signal ItemMenuButton_pressed()
signal HeroMenuButton_pressed()

var gold = GameData.player_data["gold"]

#var damage_cost = GameData.upgrade_data["cost"]["damage"]
#var agility_cost = GameData.upgrade_data["cost"]["agility"]
#
#var damage_level = GameData.upgrade_data["level"]["damage"]
#var agility_level = GameData.upgrade_data["level"]["agility"]

onready var gold_display = get_node("TopRow/GoldDisplay")

var projectiles_unlocked = false


func _ready():
	if GameData.stage_data["max_stage"] >= 10:
		projectiles_unlocked = true
	
	if projectiles_unlocked:
		get_node("UpgradeMenu/UpgradeMenuL/ProjectilesSkill/Locked").visible = false
		get_node("UpgradeMenu/UpgradeMenuL/ProjectilesSkill/HBoxContainer").visible = true
		get_node("UpgradeMenu/UpgradeMenuL/ProjectilesSkill/Level").visible = true


func _physics_process(delta):
	if GameData.stage_data["max_stage"] >= 10:
		projectiles_unlocked = true
	update_gold()
	update_damage_text()
	update_agility_text()
	update_projectiles_text()


# Damage
func _on_DamageBuyButton_pressed():
	if gold >= GameData.upgrade_data["cost"]["damage"]:
		GameData.player_data["gold"] -= GameData.upgrade_data["cost"]["damage"]
		update_gold()
		GameData.upgrade_data["level"]["damage"] += 1
		GameData.player_data["damage"] += 1
		GameData.upgrade_data["cost"]["damage"] += 10
		update_damage_text()


func update_damage_text():
	get_node("UpgradeMenu/UpgradeMenuL/DamageSkill/Level").text = "Lv" + str(GameData.upgrade_data["level"]["damage"])
	get_node("UpgradeMenu/UpgradeMenuL/DamageSkill/HBoxContainer/DamageBuyButton/HBoxContainer/Cost").text = str(GameData.upgrade_data["cost"]["damage"])
	get_node("UpgradeMenu/UpgradeMenuL/DamageSkill/HBoxContainer/VBoxContainer/Value").text = str(GameData.player_data["damage"]) + " > " + str(GameData.player_data["damage"] + 1)
	if gold >= GameData.upgrade_data["cost"]["damage"]:
		get_node("UpgradeMenu/UpgradeMenuL/DamageSkill/HBoxContainer/DamageBuyButton/HBoxContainer/Cost").set_self_modulate("ffffff")
	else: 
		get_node("UpgradeMenu/UpgradeMenuL/DamageSkill/HBoxContainer/DamageBuyButton/HBoxContainer/Cost").set_self_modulate("910c0c")


# Agility
func _on_AgilityBuyButton_pressed():
	if gold >= GameData.upgrade_data["cost"]["agility"] and GameData.upgrade_data["level"]["agility"] < 30:
		GameData.player_data["gold"] -= GameData.upgrade_data["cost"]["agility"]
		update_gold()
		GameData.upgrade_data["level"]["agility"] += 1
		GameData.player_data["agility"] += 0.15
		GameData.upgrade_data["cost"]["agility"] += 10
		update_agility_text()

func update_agility_text():
	get_node("UpgradeMenu/UpgradeMenuR/AgilitySkill/Level").text = "Lv" + str(GameData.upgrade_data["level"]["agility"])
	if GameData.upgrade_data["level"]["agility"] < 30:
		get_node("UpgradeMenu/UpgradeMenuR/AgilitySkill/HBoxContainer/AgilityBuyButton/HBoxContainer/Cost").text = str(GameData.upgrade_data["cost"]["agility"])
		get_node("UpgradeMenu/UpgradeMenuR/AgilitySkill/HBoxContainer/VBoxContainer/Value").text = str(GameData.player_data["agility"]) + " > " + str(GameData.player_data["agility"] + 0.15)
	else:
		get_node("UpgradeMenu/UpgradeMenuR/AgilitySkill/HBoxContainer/AgilityBuyButton/HBoxContainer/Cost").text = "MAXED"
		#get_node("UpgradeMenu/UpgradeMenuR/AgilitySkill/HBoxContainer/AgilityBuyButton/HBoxContainer/Cost").set_self_modulate("910c0c")
		get_node("UpgradeMenu/UpgradeMenuR/AgilitySkill/HBoxContainer/AgilityBuyButton/HBoxContainer/CoinIcon").visible = false
		#get_node("UpgradeMenu/UpgradeMenuR/AgilitySkill/HBoxContainer/AgilityBuyButton/HBoxContainer/Cost").set_align(1)
		get_node("UpgradeMenu/UpgradeMenuR/AgilitySkill/HBoxContainer/VBoxContainer/Value").text = str(GameData.player_data["agility"])

	if gold < GameData.upgrade_data["cost"]["agility"] or GameData.upgrade_data["level"]["agility"] >= 30:
		get_node("UpgradeMenu/UpgradeMenuR/AgilitySkill/HBoxContainer/AgilityBuyButton/HBoxContainer/Cost").set_self_modulate("910c0c")
	else: 
		get_node("UpgradeMenu/UpgradeMenuR/AgilitySkill/HBoxContainer/AgilityBuyButton/HBoxContainer/Cost").set_self_modulate("ffffff")


# Projectile Count
func _on_ProjectilesBuyButton_pressed():
	if gold >= GameData.upgrade_data["cost"]["projectiles"] and GameData.upgrade_data["level"]["projectiles"] < 4:
		GameData.player_data["gold"] -= GameData.upgrade_data["cost"]["projectiles"]
		update_gold()
		GameData.upgrade_data["level"]["projectiles"] += 1
		GameData.player_data["projectile_count"] += 1
		GameData.upgrade_data["cost"]["projectiles"] += 1000 * GameData.upgrade_data["level"]["projectiles"]
		update_projectiles_text()


func update_projectiles_text():
	get_node("UpgradeMenu/UpgradeMenuL/ProjectilesSkill/Level").text = "Lv" + str(GameData.upgrade_data["level"]["projectiles"])
	if GameData.upgrade_data["level"]["projectiles"] < 4:
		get_node("UpgradeMenu/UpgradeMenuL/ProjectilesSkill/HBoxContainer/ProjectilesBuyButton/HBoxContainer/Cost").text = str(GameData.upgrade_data["cost"]["projectiles"])
		get_node("UpgradeMenu/UpgradeMenuL/ProjectilesSkill/HBoxContainer/VBoxContainer/Value").text = str(GameData.player_data["projectile_count"]) + " > " + str(GameData.player_data["projectile_count"] + 1)
	else:
		get_node("UpgradeMenu/UpgradeMenuL/ProjectilesSkill/HBoxContainer/ProjectilesBuyButton/HBoxContainer/Cost").text = "MAXED"
		#get_node("UpgradeMenu/UpgradeMenuL/ProjectilesSkill/HBoxContainer/AgilityBuyButton/HBoxContainer/Cost").set_self_modulate("910c0c")
		get_node("UpgradeMenu/UpgradeMenuL/ProjectilesSkill/HBoxContainer/ProjectilesBuyButton/HBoxContainer/CoinIcon").visible = false
		#get_node("UpgradeMenu/UpgradeMenuL/ProjectilesSkill/HBoxContainer/AgilityBuyButton/HBoxContainer/Cost").set_align(1)
		get_node("UpgradeMenu/UpgradeMenuL/ProjectilesSkill/HBoxContainer/VBoxContainer/Value").text = str(GameData.player_data["projectile_count"])

	if gold < GameData.upgrade_data["cost"]["projectiles"] or GameData.upgrade_data["level"]["projectiles"] >= 4:
		get_node("UpgradeMenu/UpgradeMenuL/ProjectilesSkill/HBoxContainer/ProjectilesBuyButton/HBoxContainer/Cost").set_self_modulate("910c0c")
	else: 
		get_node("UpgradeMenu/UpgradeMenuL/ProjectilesSkill/HBoxContainer/ProjectilesBuyButton/HBoxContainer/Cost").set_self_modulate("ffffff")


func update_gold():
	gold = GameData.player_data["gold"]
	gold_display.text = str(gold)


func _on_Start_pressed():
	emit_signal("StartButton_pressed")


func _on_ItemMenuButton_pressed():
	emit_signal("ItemMenuButton_pressed")


func _on_HeroMenuButton_pressed():
	emit_signal("HeroMenuButton_pressed")
