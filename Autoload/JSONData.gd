extends Node


var hero_data: Dictionary


func _ready():
	hero_data = load_data("res://data/HeroData.json")


func load_data(file_path):
	var json_data
	var file_data = File.new()
	
	file_data.open(file_path, File.READ)
	json_data = JSON.parse(file_data.get_as_text())
	file_data.close()
	return json_data.result
