extends Node2D

class_name Hero_Display_Class

var hero_name


#func _ready():
#	if randi() % 2 == 0:
#		item_name = "Sword"
#	else:
#		item_name = "Stick"
#
#	$TextureRect.texture = load("res://item_icons/" + item_name + ".png")


func set_item(nm):
	hero_name = nm
	$TextureRect.texture = load("res://Scenes/Heroes/Assets/HeroIcons/" + hero_name + ".png")
