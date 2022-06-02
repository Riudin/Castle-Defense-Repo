extends Node


var player_data = {
	"max_health": 100,
	"health": 100,
	"damage": 1,
	"agility": 1.5,
	"projectile_count": 1,
	"gold": 0,
	"weapon_tickets": 0,
	"hero_tickets": 0
}

var stage_data = {
	"max_stage":1,
	"stage":1
}

var upgrade_data = {
	"level": {
		"damage": 0,
		"agility": 0,
		"projectiles": 0
		},
	"cost": {
		"damage": 10,
		"agility": 10,
		"projectiles": 1000
	}
}


var save_file = "user://gamedata.save"


func save_game():
	var f = File.new()
	f.open(save_file, File.WRITE)
	
	f.store_line(to_json(player_data))
	f.store_line(to_json(stage_data))
	f.store_line(to_json(upgrade_data))
	
	f.close()
	
	print("Game Saved")


func load_game():
	var f = File.new()
	if not f.file_exists(save_file):
		print("File gamedata.save not found")
		return
	
	f.open(save_file, File.READ)
	
	player_data = parse_json(f.get_line())
	stage_data = parse_json(f.get_line())
	upgrade_data = parse_json(f.get_line())
	
	f.close()
	
	print("Game Loaded")

