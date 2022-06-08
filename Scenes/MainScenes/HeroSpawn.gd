extends Node2D


onready var spawn_positions: Array = self.get_children()


func _ready():
	spawn_heroes()


func spawn_heroes():
	for i in range(spawn_positions.size()):
		if HeroInventoryManager.equips.has(i):
			var selected_hero_name = HeroInventoryManager.equips[i][0]
			var selected_hero = load("res://Scenes/Heroes/" + selected_hero_name + ".tscn").instance()
			spawn_positions[i].add_child(selected_hero)
